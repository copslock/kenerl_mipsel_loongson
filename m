Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 19:40:46 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:40162 "HELO
	duck.specifix.com") by ftp.linux-mips.org with SMTP
	id S8134026AbWFGSki (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Jun 2006 19:40:38 +0100
Received: from [127.0.0.1] (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id 9BAA5FC4E; Wed,  7 Jun 2006 11:40:22 -0700 (PDT)
Subject: Re: RTL explaination
From:	James E Wilson <wilson@specifix.com>
To:	kernel coder <lhrkernelcoder@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <f69849430606070556hb60fa66m50c58a93667e368b@mail.gmail.com>
References: <f69849430606070556hb60fa66m50c58a93667e368b@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1149705622.17313.15.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date:	Wed, 07 Jun 2006 11:40:22 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Wed, 2006-06-07 at 05:56, kernel coder wrote:
> [0 a+0 S4 A32])) -1 (nil)

This is a relatively recent addition to the RTL.  The older parts of the
documentation won't refer to them.

This is memory aliasing info.  The a+0 is the variable+offset.  The A32
is the alignment, 32-bits.  The S4 is the size, 4-bytes.  The "0" is the
alias set.  Objects are grouped into sets, where each item in the set
may alias any other item in the set.  Since you have only one item, it
is in set 0.

In the gcc sources, see the MEM_ALIAS_SET, MEM_EXPR, MEM_OFFSET,
MEM_SIZE, and MEM_ALIGN attributes for mem rtx.

This kind of question should probably go to the gcc@gcc.gnu.org list
instead of a linux kernel list.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
