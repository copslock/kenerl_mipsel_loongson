Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2006 20:38:12 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:43473 "HELO
	duck.specifix.com") by ftp.linux-mips.org with SMTP
	id S8133951AbWFETiD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Jun 2006 20:38:03 +0100
Received: from [127.0.0.1] (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id CA93EFC7D; Mon,  5 Jun 2006 12:37:32 -0700 (PDT)
Subject: Re: Re: where I can find a crosscompiler for BCM1255
From:	James E Wilson <wilson@specifix.com>
To:	richard <yczhao@hhcn.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1149406697$85109$64181664@yczhao@hhcn.com>
References: <1149406697$85109$64181664@yczhao@hhcn.com>
Content-Type: text/plain
Message-Id: <1149536252.9096.11.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date:	Mon, 05 Jun 2006 12:37:32 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Sun, 2006-06-04 at 00:38, richard wrote:
> /bin/sh: /opt/specifix/broadcom_2006a_410/mips-unknown-linux-gnu/bin/mips64-linux-gcc: cannot execute binary file

This is a mips-linux hosted cross compiler that emits code for the
mips64-linux target.

What kind of machine are you using to compile the kernel?  If it isn't a
mips-linux machine, then you can't use a mips-linux hosted compiler
binary.

You could try building a compiler yourself from the sources.  There are
some instructions on the wiki.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
