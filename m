Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 08:57:02 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.236]:60580 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039086AbXBBI46 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 08:56:58 +0000
Received: by qb-out-0506.google.com with SMTP id e12so113770qba
        for <linux-mips@linux-mips.org>; Fri, 02 Feb 2007 00:55:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nfb8DKdEYRncnV4ht3h3MG22TzrbqpBznfJSA+qYmhxOCxn2ily4ZY6KNzj/zVhE5usKZ5YqXdS/Jrlvfw1YIfIqe4W4afu3Re/QjZXGAJIDMWPLy+X7/mNOEmgMgQimbQ5kc71iSXewfxId1Li7sHXmPwOrgjVRs+4kOXa4niQ=
Received: by 10.114.110.1 with SMTP id i1mr276788wac.1170406557073;
        Fri, 02 Feb 2007 00:55:57 -0800 (PST)
Received: by 10.114.134.16 with HTTP; Fri, 2 Feb 2007 00:55:56 -0800 (PST)
Message-ID: <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com>
Date:	Fri, 2 Feb 2007 09:55:56 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"David Daney" <ddaney@avtrex.com>
Subject: Re: Question about signal syscalls !
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <45C21CFE.9060804@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com>
	 <20070201135734.GB12728@linux-mips.org>
	 <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com>
	 <45C21CFE.9060804@avtrex.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/1/07, David Daney <ddaney@avtrex.com> wrote:
> I don't think *any* registers *need* to be saved on sys_sigreturn().
> The values in sigcontext on the user stack associated with the system
> call are all used instead of the actual register values.
>

Sorry but I don't understand what you mean. Could you explain ?

Thanks
-- 
               Franck
