Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 10:44:19 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.228]:54086 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038907AbXBAKoP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Feb 2007 10:44:15 +0000
Received: by qb-out-0506.google.com with SMTP id e12so37012qba
        for <linux-mips@linux-mips.org>; Thu, 01 Feb 2007 02:43:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mgMbkbW3tIkDd1pfS2VXZ4aESMc4LKCOK0jJlDMwwIh/S8fNUniFw71makLPBbGb8h81EdbrVT7DSbPJXeW+IeiFbfJMI8xfGMVkBshH24lkgrFVH9V4Wprtc95wWo2sHvF6S997geQBM28Q2gTyFrgioxRBYlS07P2tVwnqMU4=
Received: by 10.114.13.1 with SMTP id 1mr137544wam.1170326593259;
        Thu, 01 Feb 2007 02:43:13 -0800 (PST)
Received: by 10.114.134.16 with HTTP; Thu, 1 Feb 2007 02:43:13 -0800 (PST)
Message-ID: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com>
Date:	Thu, 1 Feb 2007 11:43:13 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Question about signal syscalls !
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm probably missing something very obvious so the subject could have
been "Dumb question of the week". So please be nice when answering ;)

I'm wondering why we need to save/restore the static registers
(s0...s7) when dealing with some  signal system calls. Specially all
of them which are declared by using save_static_function() macros.

Thanks
-- 
               Franck
