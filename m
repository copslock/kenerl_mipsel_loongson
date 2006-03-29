Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 23:22:38 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:52180 "EHLO
	duck.specifix.com") by ftp.linux-mips.org with ESMTP
	id S8133574AbWC2WW3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Mar 2006 23:22:29 +0100
Received: from [127.0.0.1] (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id 5F94CFA8B; Wed, 29 Mar 2006 14:33:02 -0800 (PST)
Subject: Re: compilation problem with kernel 2.6.15
From:	James E Wilson <wilson@specifix.com>
To:	dhunjukrishna@gmail.com
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <20060329114903.9537.qmail@web53511.mail.yahoo.com>
References: <20060329114903.9537.qmail@web53511.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1143671582.18512.16.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date:	Wed, 29 Mar 2006 14:33:02 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Wed, 2006-03-29 at 03:49, Krishna wrote:
>   CHK     usr/initramfs_list
> 
> /home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/scripts/gen_initramfs_list.sh:
>  Cannot open 'y'

Use the command
    make V=1
to get slightly more useful make output.

If this doesn't show anything wrong, then try running the script
manually with shell tracing turned on.
   cd scripts
   sh -x gen_initramfs_list.sh

This doesn't look like a compiler issue.  It looks more like an issue
with your system, or with the kernel sources that you have extracted. 
The only thing happening here is that a shell script is being run from
make.  I don't see how this could have happened unless something is
wrong with your system.

What OS name and version are you using?  What shell program and
version?  What make program and version?
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
