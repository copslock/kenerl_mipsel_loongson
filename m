Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2006 17:48:22 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.206]:65262 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133489AbWBIRsN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Feb 2006 17:48:13 +0000
Received: by zproxy.gmail.com with SMTP id l8so214001nzf
        for <linux-mips@linux-mips.org>; Thu, 09 Feb 2006 09:54:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IljwgaglojBYOUCjSMjk1KN/UWUya3aGB9US6PpMoXaSuTAbZJFCzg0A/t9HCD3NdcNGm3Tr4U4F0KQyCQ0FYnlyjXs8fQXDw+xKN6i1L309wD9vtOf9ywc5amLxFmnHWnuJegGLVC/2SUv2PnAlVEY7wYKVuI0vYfXk9ocFvPk=
Received: by 10.36.97.18 with SMTP id u18mr3793491nzb;
        Thu, 09 Feb 2006 09:54:05 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Thu, 9 Feb 2006 09:54:05 -0800 (PST)
Message-ID: <cda58cb80602090954s46ba0d78s@mail.gmail.com>
Date:	Thu, 9 Feb 2006 18:54:05 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Fix build error by removal of obsoleted au1x00_uart driver.
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
In-Reply-To: <20060209164412.GB3558@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060210.004302.96686142.anemo@mba.ocn.ne.jp>
	 <20060209154959.GA3558@linux-mips.org>
	 <20060210.012559.89066702.anemo@mba.ocn.ne.jp>
	 <20060209164412.GB3558@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/2/9, Ralf Baechle <ralf@linux-mips.org>:
> When cloning such a repository git isn't actually downloading the
> .git/info/grafts file.  This results in such errors.  I don't know of a
> way to get git to do this right.  You may download the file manually

you can't. It seems that graft thing is, for now, only used to change
your _own_ repository's history. Fetching from a "cautorized"
repository is a risky job and you might have bad results.

It's going to change with the "shallow-clone" thing, but I don't know
when it will come out...

--
               Franck
