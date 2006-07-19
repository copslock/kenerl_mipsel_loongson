Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2006 19:35:39 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:4249 "EHLO
	duck.specifix.com") by ftp.linux-mips.org with ESMTP
	id S3949399AbWGSSfa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Jul 2006 19:35:30 +0100
Received: from [127.0.0.1] (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id 8C1D1FC70; Wed, 19 Jul 2006 11:35:03 -0700 (PDT)
Subject: Re: cross compiling gcc for mips
From:	James E Wilson <wilson@specifix.com>
To:	qi tao <demon19840308@hotmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <BAY122-F271C1ACCD1969B2F38611AAD630@phx.gbl>
References: <BAY122-F271C1ACCD1969B2F38611AAD630@phx.gbl>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1153334103.18674.18.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date:	Wed, 19 Jul 2006 11:35:03 -0700
Content-Transfer-Encoding: 8bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Tue, 2006-07-18 at 00:12, qi tao wrote:
> First I built binutils and now I was setting up the bootstrap compiler.
> In file included from ../../gcc-4.1.1/gcc/crtstuff.c:68:
> .../../gcc-4.1.1/gcc/tsystem.h:90:19: error: stdio.h: 没有那个文件或目录

You can't build the gcc libraries unless you have a C library first. 
And, of course, you can't build a C library unless you have a compiler
first.  This circular dependency makes bootstrapping a bit tricky.  

The basic process here is that you have to do a glibc make
install-headers first which gives you C library headers, and then a
partial gcc build minus the libraries, then a full glibc build, then a
full gcc build.

This is simpler is you just follow instructions written up by someone
else who already knows how to do it.  The one I recommend is the
crosstool scrips written by Dan Kegel.  There is a pointer to them on
the linux-mips.org wiki.
    http://www.linux-mips.org/wiki/Toolchains
    http://kegel.com/crosstool/
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
