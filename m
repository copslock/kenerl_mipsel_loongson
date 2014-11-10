Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 13:32:58 +0100 (CET)
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:64402 "EHLO
        cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbaKJMc4JEEV6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 13:32:56 +0100
Received: from cpsps-ews26.kpnxchange.com ([10.94.84.192]) by cpsmtpb-ews09.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 10 Nov 2014 13:32:49 +0100
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews26.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 10 Nov 2014 13:32:49 +0100
Received: from [192.168.10.108] ([77.173.140.92]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 10 Nov 2014 13:32:49 +0100
Message-ID: <1415622769.21229.15.camel@x220>
Subject: Re: MIPS: ralink: CONFIG_RALINK_ILL_ACC?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     John Crispin <blogic@openwrt.org>
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Nov 2014 13:32:49 +0100
In-Reply-To: <544E188B.9000707@openwrt.org>
References: <1414403681.28499.4.camel@x220> <544E188B.9000707@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Nov 2014 12:32:49.0369 (UTC) FILETIME=[70493C90:01CFFCE2]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi John,

This message never made it to my Inbox. I copied it from a mips' list
archive om the web. That kept this issue on my TODO list, although it
actually was resolved quite quickly.

On Mon, 2014-10-27 at 11:03 +0100, John Crispin wrote:
> On 27/10/2014 10:54, Paul Bolle wrote:
> > Your commit 78865eacb4aa ("MIPS: ralink: add illegal access
> > driver") landed in today's linux-next (ie, next-20141027). That
> > commit dates back to May 16, 2013! It adds a driver that is built
> > if CONFIG_RALINK_ILL_ACC is set. But there's no Kconfig symbol
> > RALINK_ILL_ACC.
> > 
> > I assume that patch that adds this symbol is queued somewhere. Is
> > that correct?
> 
> i'll look into it. the commit that move all dts files to a central
> folder broke some of my patches so i had to rebase them. apparently
> the bit that adds the symbol got lost.

(CONFIG_RALINK_ILL_ACC was already gone in next-20141029. So that issue
is resolved, as far as I care.)

> out of interest, how did you spot this ?

See https://lkml.org/lkml/2014/9/26/456:
    I have a 800 line perl monster that checks for stuff like this. It's not
    very sophisticated but smart enough to spot typos like this one. I try
    to have it check each linux-next (and mainline) release.

    (I think Valentin Rothberg is trying to automate this properly. See
    http://www.linuxplumbersconf.org/2014/ocw/sessions/1863 .)

This is the last time I'll put pressure on Valentin _publicly_, I
promise!


Paul Bolle
