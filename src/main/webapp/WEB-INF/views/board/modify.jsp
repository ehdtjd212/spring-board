<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .container { margin-top: 50px; max-width: 800px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="card shadow">
            <div class="card-header bg-warning text-dark">
                <h4 class="m-0 fw-bold">🛠️ 글 수정하기</h4>
            </div>
            <div class="card-body p-4">
                <form action="/board/modify" method="post">
                    <input type="hidden" name="id" value="${board.id}">

                    <div class="mb-3">
                        <label class="form-label fw-bold">제목</label>
                        <input type="text" name="title" class="form-control" value="${board.title}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">작성자</label>
                        <input type="text" name="writer" class="form-control" value="${board.writer}" readonly> </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">내용</label>
                        <textarea name="content" class="form-control" rows="10" required>${board.content}</textarea>
                    </div>
                    <div class="text-end">
                        <button type="button" onclick="history.back()" class="btn btn-secondary">취소</button>
                        <button type="submit" class="btn btn-warning">수정 완료</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>