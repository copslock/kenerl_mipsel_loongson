Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2006 12:35:36 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.175]:18181 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133452AbWG0Lf2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Jul 2006 12:35:28 +0100
Received: by ug-out-1314.google.com with SMTP id y2so184664uge
        for <linux-mips@linux-mips.org>; Thu, 27 Jul 2006 04:35:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=Aimc+1ifDFmRNrFxSvIhUQYw7eytev1iiDqHDxxvXQJ6Rf8l7GXSTCKc0wpiQqNQ2g4IdRSQuDwevx7TFic36Pc5IQTD+X8bDkS9YBPZ4n0ro81Fn94j9aRJ4wyIA/e2Jw+pH7IZsDOhRsRRBP6Wz6GUzHamWgjfBOmcUHgKNNk=
Received: by 10.66.220.17 with SMTP id s17mr7074813ugg;
        Thu, 27 Jul 2006 04:35:26 -0700 (PDT)
Received: by 10.67.23.12 with HTTP; Thu, 27 Jul 2006 04:35:26 -0700 (PDT)
Message-ID: <218a54980607270435y778c4b79w5b9bb0fb0a435aa@mail.gmail.com>
Date:	Thu, 27 Jul 2006 07:35:26 -0400
From:	"Peter Watkins" <treestem@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] For N32 rt_sigqueueinfo uses O32 padding, not N64.
In-Reply-To: <218a54980607261642i55966303r791f29791bab5588@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_20871_31264724.1154000126872"
References: <218a54980607261642i55966303r791f29791bab5588@mail.gmail.com>
Return-Path: <treestem@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: treestem@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_20871_31264724.1154000126872
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 For N32 rt_sigqueueinfo uses O32 padding, not N64.

------=_Part_20871_31264724.1154000126872
Content-Type: application/octet-stream; name=patch-scall64
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eq4cc60u
Content-Disposition: attachment; filename="patch-scall64"

RGF0ZTogV2VkLCAyNiBKdWwgMjAwNiAxOToyNjoxMiAtMDQwMApTdWJqZWN0OiBGb3IgTjMyIHJ0
X3NpZ3F1ZXVlaW5mbyB1c2VzIE8zMiBwYWRkaW5nLCBub3QgTjY0LgotLS0KIGFyY2gvbWlwcy9r
ZXJuZWwvc2NhbGw2NC1uMzIuUyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9rZXJuZWwvc2Nh
bGw2NC1uMzIuUyBiL2FyY2gvbWlwcy9rZXJuZWwvc2NhbGw2NC1uMzIuUwppbmRleCA5OGFiYmM1
Li41NDliNGJjIDEwMDY0NAotLS0gYS9hcmNoL21pcHMva2VybmVsL3NjYWxsNjQtbjMyLlMKKysr
IGIvYXJjaC9taXBzL2tlcm5lbC9zY2FsbDY0LW4zMi5TCkBAIC0yNDcsNyArMjQ3LDcgQEAgRVhQ
T1JUKHN5c24zMl9jYWxsX3RhYmxlKQogCVBUUglzeXNfY2Fwc2V0CiAJUFRSCXN5czMyX3J0X3Np
Z3BlbmRpbmcJCS8qIDYxMjUgKi8KIAlQVFIJY29tcGF0X3N5c19ydF9zaWd0aW1lZHdhaXQKLQlQ
VFIJc3lzX3J0X3NpZ3F1ZXVlaW5mbworCVBUUglzeXMzMl9ydF9zaWdxdWV1ZWluZm8KIAlQVFIJ
c3lzbjMyX3J0X3NpZ3N1c3BlbmQKIAlQVFIJc3lzMzJfc2lnYWx0c3RhY2sKIAlQVFIJY29tcGF0
X3N5c191dGltZQkJLyogNjEzMCAqLwotLSAKMS40LjEKCg==
------=_Part_20871_31264724.1154000126872--
