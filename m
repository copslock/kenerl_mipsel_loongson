Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2012 16:41:37 +0200 (CEST)
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:3987 "EHLO
        smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903611Ab2C3Olb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2012 16:41:31 +0200
Received: from starbug-2.trinair2002 (dhcp-089-098-069-120.chello.nl [89.98.69.120])
        (authenticated bits=0)
        by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id q2UEevoc081469;
        Fri, 30 Mar 2012 16:40:59 +0200 (CEST)
        (envelope-from maarten@treewalker.org)
Received: from hyperion.localnet (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.trinair2002 (Postfix) with ESMTP id BE6493DF2B;
        Fri, 30 Mar 2012 16:40:56 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?ISO-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] MIPS: Enable vmlinuz for JZ4740
Date:   Fri, 30 Mar 2012 16:47:14 +0200
Message-ID: <2122560.hRnRRue4n0@hyperion>
User-Agent: KMail/4.8.0 (Linux/3.1.9-1.4-default; KDE/4.8.1; x86_64; ; )
In-Reply-To: <4F75A48F.8010307@mvista.com>
References: <1333037360-18382-1-git-send-email-maarten@treewalker.org> <3042754.g6sLXu44Oc@hyperion> <4F75A48F.8010307@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Virus-Scanned: by XS4ALL Virus Scanner
X-archive-position: 32830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Friday 30 March 2012 16:18:23 Sergei Shtylyov wrote:

>     I should have said: why the variable is handled as a special case for
> JZ4740?

All existing boot loaders for the JZ4740 systems that we support, being the 
Ben NanoNote (already in mainline) and the Dingoo A320 (not in mainline 
yet), seem to be using 0x80600000 as a hardcoded load address. I don't know 
the origin of this convention.

I'll prepare a new patch with the spaces around ":=" added.

Bye,
		Maarten
