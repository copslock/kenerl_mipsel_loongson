Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2006 12:43:40 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:50198 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8134006AbWG0Lnb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Jul 2006 12:43:31 +0100
Received: by ug-out-1314.google.com with SMTP id y2so187402uge
        for <linux-mips@linux-mips.org>; Thu, 27 Jul 2006 04:43:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=CIre+qD1mvO0oduxFBqg3G/mb3L9f9+f3lyTspyuTxNK86CfjNla0UMHJ4fQ2ZXhDmralhlKbNG3vFEmK2u/80+hbIcRtgMj23dGxUavPVr/CJ2BS3R9h3/4J4U1GXODz62q9TCjVbywUOHsV3q/+H4J9rt1jNwky4G6h6Gd9PI=
Received: by 10.66.244.10 with SMTP id r10mr6975320ugh;
        Thu, 27 Jul 2006 04:43:31 -0700 (PDT)
Received: by 10.67.23.12 with HTTP; Thu, 27 Jul 2006 04:43:31 -0700 (PDT)
Message-ID: <218a54980607270443i7b896d68p2a048a6ba8b0f37e@mail.gmail.com>
Date:	Thu, 27 Jul 2006 07:43:31 -0400
From:	"Peter Watkins" <treestem@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] For N32 rt_sigqueueinfo uses O32 padding, not N64.
In-Reply-To: <218a54980607270435y778c4b79w5b9bb0fb0a435aa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_21019_33340978.1154000611443"
References: <218a54980607261642i55966303r791f29791bab5588@mail.gmail.com>
	 <218a54980607270435y778c4b79w5b9bb0fb0a435aa@mail.gmail.com>
Return-Path: <treestem@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: treestem@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_21019_33340978.1154000611443
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 For N32 rt_sigqueueinfo uses O32 padding, not N64.

------=_Part_21019_33340978.1154000611443
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
------=_Part_21019_33340978.1154000611443--
