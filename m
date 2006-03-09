Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2006 09:43:37 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:50314 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133398AbWCIJn3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Mar 2006 09:43:29 +0000
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id EBCAEC01B;
	Thu,  9 Mar 2006 10:51:59 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id 746851BC089;
	Thu,  9 Mar 2006 10:52:02 +0100 (CET)
Received: from kupljenlap (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id DA3C11A18B2;
	Thu,  9 Mar 2006 10:52:01 +0100 (CET)
Subject: Re: help
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	zhaoyw <zhaoyw@langchao.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <440F999F.4040703@langchao.com>
References: <440F999F.4040703@langchao.com>
Content-Type: text/plain
Date:	Thu, 09 Mar 2006 10:51:59 +0100
Message-Id: <1141897920.7135.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> I seem to get cross-compile using Buildroot . And tinyx included .
> But when I nfs program to my target board. It can not run.
> Prompt is : /usr/X11R6/bin/Xfbdev:1: syntax error : " ( " unexpected.

Are you sure, this is a cross compiled binary?
Check it with the file command on the host machine, like:
# file Xfbdev

BR,
Matej
