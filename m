Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2012 11:47:28 +0200 (CEST)
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:4683 "EHLO
        smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903608Ab2C3JrV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2012 11:47:21 +0200
Received: from starbug-2.trinair2002 (dhcp-089-098-069-120.chello.nl [89.98.69.120])
        (authenticated bits=0)
        by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id q2U9ktRp024520;
        Fri, 30 Mar 2012 11:46:55 +0200 (CEST)
        (envelope-from maarten@treewalker.org)
Received: from hyperion.localnet (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.trinair2002 (Postfix) with ESMTP id DCB633DF2B;
        Fri, 30 Mar 2012 11:46:54 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?ISO-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] MIPS: Enable vmlinuz for JZ4740
Date:   Fri, 30 Mar 2012 11:53:12 +0200
Message-ID: <3042754.g6sLXu44Oc@hyperion>
User-Agent: KMail/4.8.0 (Linux/3.1.9-1.4-default; KDE/4.8.1; x86_64; ; )
In-Reply-To: <4F74E210.70707@mvista.com>
References: <1333037360-18382-1-git-send-email-maarten@treewalker.org> <4F74E210.70707@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Virus-Scanned: by XS4ALL Virus Scanner
X-archive-position: 32823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Friday 30 March 2012 02:28:32 Sergei Shtylyov wrote:

[...]

> > +ifeq ($(CONFIG_MACH_JZ4740),y)
> > +VMLINUZ_LOAD_ADDRESS:=0x80600000
> 
>     Spaces around :=, please. And why this should be out of order case?

I can add spaces, no problem.

I don't understand your question though. Do you mean why there is a 
different address for the JZ4740 platform? Or why the variable name is in 
upper case? Or something else?

Bye,
		Maarten
