Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2006 21:15:10 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:24784 "EHLO
	bluesmobile.corp.specifix.com") by ftp.linux-mips.org with ESMTP
	id S20039018AbWI0UPI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Sep 2006 21:15:08 +0100
Received: from localhost.localdomain (bluesmobile.specifix.com [64.220.152.99])
	by bluesmobile.corp.specifix.com (Postfix) with ESMTP id 5BECC3B849;
	Wed, 27 Sep 2006 13:09:34 -0700 (PDT)
Subject: Re: How to emulate lw/sw instruction by lb/sb instruction
From:	Jim Wilson <wilson@specifix.com>
To:	william_lei@ali.com.tw
Cc:	linux-mips@linux-mips.org
In-Reply-To: <OFCDEA2C7E.BF7FD296-ON482571F4.0039233C-482571F4.003A3A12@LocalDomain>
References: <OFCDEA2C7E.BF7FD296-ON482571F4.0039233C-482571F4.003A3A12@LocalDomain>
Content-Type: text/plain
Date:	Wed, 27 Sep 2006 13:14:11 -0700
Message-Id: <1159388051.3181.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Mon, 2006-09-25 at 18:35 +0800, william_lei@ali.com.tw wrote:
>       Because there are some aligned instruction will load/store from/to
> unaligned base address in some module,such as "lw t0,56(sp)  ##sp is odd
> address"

You are better off fixing your code.  SP must always be aligned to an 8
byte boundary minimum, 16 bytes for the New ABIs.

Changing gcc would be difficult, and it isn't even clear if such a
change can be made to work.  If it is possible, the resulting code will
likely be so bad as to be nearly useless.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
