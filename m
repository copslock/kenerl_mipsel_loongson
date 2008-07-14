Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 19:29:38 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:53518 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S28578205AbYGNS3g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jul 2008 19:29:36 +0100
Received: from [10.11.16.99] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Mon, 14 Jul 2008 11:29:18 -0700
X-Server-Uuid: D3C04415-6FA8-4F2C-93C1-920E106A2031
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 BFB222B1; Mon, 14 Jul 2008 11:29:18 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id AAEF62B0; Mon, 14 Jul
 2008 11:29:18 -0700 (PDT)
Received: from mail-irva-13.broadcom.com (mail-irva-13.broadcom.com
 [10.11.16.103]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id GZU46881; Mon, 14 Jul 2008 11:29:12 -0700 (PDT)
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id 9AE7274CFF; Mon,
 14 Jul 2008 11:29:11 -0700 (PDT)
Subject: RE: sparse or discontiguous  memory on 32bit mips platform
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	"Sundius, Michael" <michael.sundius@sciatl.com>
cc:	linux-mips@linux-mips.org, msundius@sundius.com
In-Reply-To: <D331130DD3DA194B96EF57DA3415F50A026331BE@SAUSCUPEXCH01.corp.sa.net>
References: <D331130DD3DA194B96EF57DA3415F50A026331BB@SAUSCUPEXCH01.corp.sa.net>
 <1216054738.30304.45.camel@chaos.ne.broadcom.com>
 <D331130DD3DA194B96EF57DA3415F50A026331BE@SAUSCUPEXCH01.corp.sa.net>
Organization: Broadcom
Date:	Mon, 14 Jul 2008 14:29:10 -0400
Message-ID: <1216060150.30304.51.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8)
X-WSS-ID: 646545743D088985529-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips

Mike,

I'll run some diffs and post them.  It'll take a little bit
for me to sort out the changes.  I don't have a 'use second bank of 
memory' patch per se.


You'll definitely want to pick up the HIGHMEM changes that were posted.
If you have 4K pages and more than 16K of cache (assuming 4 cache ways),
you need the patches to deal with cache aliases.

Jon

On Mon, 2008-07-14 at 10:20 -0700, Sundius, Michael wrote:
> 
> | I have something similar.  Under 2.6.24, I have the following
> | configured:
> |
> | CONFIG_HIGHMEM=y
> | CONFIG_CPU_SUPPORTS_HIGHMEM=y
> | CONFIG_SYS_SUPPORTS_HIGHMEM=y
> | CONFIG_ARCH_FLATMEM_ENABLE=y
> | CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
> | CONFIG_DISCONTIGMEM=y
> | CONFIG_FLAT_NODE_MEM_MAP=y
> | CONFIG_ARCH_POPULATES_NODE_MAP=y
> | CONFIG_NODES_SHIFT=6
> | CONFIG_FLAT_NODE_MEM_MAP=y
> | CONFIG_NEED_MULTIPLE_NODES=y
> |
> |
> | Each bank of memory is in a separate node. I did have to write
> | some code in arch/mips/kernel/setup.c to setup the multiple memory
> | regions.  I used some of the PPC NUMA code as an example, IIRC.
> |
> | Because my second bank of mem starts at 0x20000000,
> | I use HIGHMEM to access it.  There been some HIGHMEM info
> | posted to this list in the last 6 months.
> |
> | I didn't think my efforts were general enough to post, but maybe
> | more people are doing these discontiguous memory platforms.
> 
> Oh, yes, that is very similar to what I want to do. we currently
> use HIGHMEM to access our 2nd bank of memory, and so its the
> setup of the additional node that we'd like to use. I'd be
> interested in seeing that patch if possible.
> 
> thanks Mike
> 
> 
> 
> ______________________________________________________________________
> 
>       - - - - -                              Cisco
> - - - - -         
> This e-mail and any attachments may contain information which is
> confidential, 
> proprietary, privileged or otherwise protected by law. The information
> is solely 
> intended for the named addressee (or a person responsible for
> delivering it to 
> the addressee). If you are not the intended recipient of this message,
> you are 
> not authorized to read, print, retain, copy or disseminate this
> message or any 
> part of it. If you have received this e-mail in error, please notify
> the sender 
> immediately by return e-mail and delete it from your computer.
