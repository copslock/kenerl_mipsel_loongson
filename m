Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2018 12:42:36 +0200 (CEST)
Received: from heliosphere.sirena.org.uk ([IPv6:2a01:7e01::f03c:91ff:fed4:a3b6]:41858
        "EHLO heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994243AbeIDKmckdQzT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2018 12:42:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eGd++n1HkrVuPsznha6zT6oPZKiJwit9QuQ80CfcEOg=; b=Seczex8Twhqhd04xAEELCcRQX
        k95PY6emLY6UwTDZbMKof9oHVupbzvmLUxziz131dYTaFGGG5YCKCXQG16JciahnRZvplHxZFc757
        w7b+vxGqsXBnAcOD8tHNVQnyh0c1hVogoffYu2KIzQ7lvvnY1yt9kz+4KmjoFmhbWEcsM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fx8m1-0001FV-94; Tue, 04 Sep 2018 10:41:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0D93111227D8; Tue,  4 Sep 2018 11:41:29 +0100 (BST)
Date:   Tue, 4 Sep 2018 11:41:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Henrik Austad <henrik@austad.us>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Karsten Keil <isdn@linux-pingi.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jan Kandziora <jjj@gmx.de>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org,
        netdev@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mips@linux-mips.org, linux-security-module@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-spi@vger.kernel.org, kvm@vger.kernel.org,
        Henrik Austad <haustad@cisco.com>
Subject: Re: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
Message-ID: <20180904104129.GB12993@sirena.org.uk>
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <1536012923-16275-1-git-send-email-henrik@austad.us>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@kernel.org
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


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 12:15:23AM +0200, Henrik Austad wrote:
> This is a respin with a wider audience (all that get_maintainer returned)
> and I know this spams a *lot* of people. Not sure what would be the correct
> way, so my apologies for ruining your inbox.

Acked-by: Mark Brown <broonie@kernel.org>

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOYVgACgkQJNaLcl1U
h9AYzQgAhduv2URwLqYje3JPZtGLqtLxGgecyHS/ksa1VCCcPy8kltd2kZ8xOeys
+n8FKms8rzw5bCeyggflQj54NZhlSt+gBMjCKx+A8swUeqcfHp7GmI+MPeF2PUGr
UhdoTr8/roMv7kA67RzNkzquvenYFSDtFFqDklULYikGBbMs3uACTGyaIxVhyU5x
tWiVzem5oybY2SwnokmrT7aiM2asAg89X7PvSZytgef09Hb4FtKptTIYr0p5RVS9
2M90CByKZ7P86IKpAVGn5y9rhDPVEOuMq37XrlDDa57Hr71V5qZbYXCPWyvI0+oo
U3tAq34v0zey0x1/+mZd3Cl6zUBJng==
=oJFX
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
