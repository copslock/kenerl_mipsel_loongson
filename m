Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8E1bCx19085
	for linux-mips-outgoing; Thu, 13 Sep 2001 18:37:12 -0700
Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8E1bAe19080
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 18:37:10 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id SAA07491
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 18:35:44 -0700 (PDT)
	mail_from (kaos@melbourne.sgi.com)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180])
	by nodin.corp.sgi.com (8.11.4/8.11.2/nodin-1.0) with ESMTP id f8E1a8541728618;
	Thu, 13 Sep 2001 18:36:09 -0700 (PDT)
Received: by kao2.melbourne.sgi.com (Postfix, from userid 16331)
	id 51486300090; Fri, 14 Sep 2001 11:35:18 +1000 (EST)
Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])
	by kao2.melbourne.sgi.com (Postfix) with ESMTP
	id 065CAAB; Fri, 14 Sep 2001 11:35:17 +1000 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@melbourne.sgi.com>
To: Gerald Champagne <gerald.champagne@esstech.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: How can I determine which files are used? 
In-reply-to: Your message of "Thu, 13 Sep 2001 16:43:19 EST."
             <3BA12877.6030505@esstech.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 Sep 2001 11:35:12 +1000
Message-ID: <13641.1000431312@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 13 Sep 2001 16:43:19 -0500, 
Gerald Champagne <gerald.champagne@esstech.com> wrote:
>Is there a recommended method of determining which files in the
>Linux source tree are used with a given .config file?

Not with the current kernel build system.  Kernel build 2.5[*] provides
the information you need but the existing system does not.

The best you can do with the current system is to make clean, make dep,
touch stamp, make bzImage modules.  Then find all files accessed after
make dep finished using find -type f -anewer stamp.

[*]http://sourceforge.net/projects/kbuild
