<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .container { margin-top: 50px; max-width: 800px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h4 class="m-0 fw-bold">✏️ 새 글 작성</h4>
            </div>
            <div class="card-body p-4">
                <form action="/board/write" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-bold">제목</label>
                        <input type="text" name="title" class="form-control" placeholder="제목을 입력하세요" required>
                    </div>
                   <div class="mb-3">
                       <label class="form-label fw-bold">작성자</label>
                       <input type="text" name="writer" class="form-control"
                              value="${sessionScope.member.name}" readonly style="background-color: #e9ecef;">
                   </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">내용</label>
                        <textarea name="content" class="form-control" rows="10" placeholder="내용을 입력하세요" required></textarea>
                    </div>
                    <div class="text-end">
                        <a href="/board/list" class="btn btn-secondary">취소</a>
                        <button type="submit" class="btn btn-primary">저장하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>