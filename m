Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Nov 2010 06:17:50 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:46226 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491029Ab0KAFRm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Nov 2010 06:17:42 +0100
Received: by gxk25 with SMTP id 25so3222781gxk.36
        for <multiple recipients>; Sun, 31 Oct 2010 22:17:36 -0700 (PDT)
Received: by 10.229.219.10 with SMTP id hs10mr14454945qcb.238.1288588656574;
        Sun, 31 Oct 2010 22:17:36 -0700 (PDT)
Received: from angua ([12.157.84.6])
        by mx.google.com with ESMTPS id x20sm1395919vcr.47.2010.10.31.22.17.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 22:17:35 -0700 (PDT)
Received: by angua (Postfix, from userid 1000)
        id 524FB3C00E5; Mon,  1 Nov 2010 05:17:34 +0000 (GMT)
Date:   Mon, 1 Nov 2010 01:17:34 -0400
From:   Grant Likely <grant.likely@secretlab.ca>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Wolfram Sang <w.sang@pengutronix.de>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Corey Minyard <cminyard@mvista.com>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Vitaly Bordug <vbordug@ru.mvista.com>,
        Anatolij Gustschin <agust@denx.de>,
        John Rigby <jcrigby@gmail.com>, Wolfgang Denk <wd@denx.de>,
        Anton Vorontsov <avorontsov@mvista.com>,
        Sandeep Gopalpet <Sandeep.Kumar@freescale.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoli@freescale.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Jiri Pirko <jpirko@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Sean MacLennan <smaclennan@pikatech.com>,
        Sadanand Mutyala <Sadanand.Mutyala@xilinx.com>,
        Andres Salomon <dilinger@queued.net>,
        microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] OF device tree: Move of_get_mac_address() to a common
 source file.
Message-ID: <20101101051734.GB17587@angua.secretlab.ca>
References: <1288130833-16421-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288130833-16421-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Tue, Oct 26, 2010 at 03:07:13PM -0700, David Daney wrote:
> There are two identical implementations of of_get_mac_address(), one
> each in arch/powerpc/kernel/prom_parse.c and
> arch/microblaze/kernel/prom_parse.c.  Move this function to a new
> common file of_net.{c,h} and adjust all the callers to include the new
> header.

Applied, thanks; but made some changes to protect this code because it
does not work on little endian (it can be fixed in a separate patch)

Also...

> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Corey Minyard <cminyard@mvista.com>
> Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>
> Cc: Vitaly Bordug <vbordug@ru.mvista.com>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: John Rigby <jcrigby@gmail.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Anton Vorontsov <avorontsov@mvista.com>
> Cc: Sandeep Gopalpet <Sandeep.Kumar@freescale.com>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Li Yang <leoli@freescale.com>
> Cc: Sergey Matyukevich <geomatsi@gmail.com>
> Cc: Jiri Pirko <jpirko@redhat.com>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Sean MacLennan <smaclennan@pikatech.com>
> Cc: Sadanand Mutyala <Sadanand.Mutyala@xilinx.com>
> Cc: Andres Salomon <dilinger@queued.net>
> Cc: microblaze-uclinux@itee.uq.edu.au
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: netdev@vger.kernel.org
> Cc: devicetree-discuss@lists.ozlabs.org

You don't need to believe everything that get_maintainers is telling
you.  When you get a large list like this, don't Cc everyone, but
apply some educated guesses.  You can guess that the PowerPC and
Microblaze maintainers care because it touches their trees, and you
can guess that I care because I'm the dt maintainer. David Miller
isn't a bad guess because of networking.  But 22 people is excessive.

g.
