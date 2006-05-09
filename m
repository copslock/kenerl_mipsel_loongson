Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 May 2006 16:35:23 +0200 (CEST)
Received: from ug-out-1314.google.com ([66.249.92.173]:55500 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133859AbWEIOfO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 May 2006 16:35:14 +0200
Received: by ug-out-1314.google.com with SMTP id u40so264295ugc
        for <linux-mips@linux-mips.org>; Tue, 09 May 2006 07:35:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=a7BCCerGewrZJp0ufQxDU8mMxWqCvKHzgPzB+SDt6u5cOza8FHZKplwnB/eLeLmoxLyqbl33Kkqz0YaThUn4zi++bcefNEV8rjge6oWWXHiUOGLVJOHrLaWSs7eoiCJcBgbo0K8bFRnZs/I7Nn8HFlaRCTNF8MKbVeYc/qZLSk4=
Received: by 10.78.17.4 with SMTP id 4mr798270huq;
        Tue, 09 May 2006 07:35:14 -0700 (PDT)
Received: by 10.78.39.13 with HTTP; Tue, 9 May 2006 07:35:14 -0700 (PDT)
Message-ID: <c58a7a270605090735t8e4f21ax6ca87f97b9143e3b@mail.gmail.com>
Date:	Tue, 9 May 2006 15:35:14 +0100
From:	"Alex Gonzalez" <langabe@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Boot time memory allocation
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <langabe@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: langabe@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I have two independent processors with access to a shared memory
region, mapped in the 256MB to 512MB region (kseg0).

One is running a propietary OS, and the second one is running Linux 2.6.12.

How would I arrange to leave that shared memory region out of the
scope of Linux's memory management system, but at the same time make
it possible for a driver to access it?

I have done similar things before with the help of alloc_bootmem, but
this time I don't want the kernel to reserve the memory, I want the
kernel to be completely unaware of it, and I need to specify its start
and end.

Any idea very much welcomed, thanks
Alex
