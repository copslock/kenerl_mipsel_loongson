Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2016 21:50:52 +0200 (CEST)
Received: from mout.kundenserver.de ([217.72.192.74]:58470 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026777AbcDPTuuuGkre (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Apr 2016 21:50:50 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue101) with ESMTPSA (Nemesis) id 0LkPhj-1bSVcE0PLH-00cOJB; Sat, 16 Apr
 2016 21:50:29 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] phy: Add a driver for simple phy
Date:   Sat, 16 Apr 2016 21:50:26 +0200
Message-ID: <4848615.OezLJod6Cv@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <570F303A.6030605@ti.com>
References: <1447708924-15076-1-git-send-email-albeu@free.fr> <1447708924-15076-2-git-send-email-albeu@free.fr> <570F303A.6030605@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:MWlb3iJYHvJ7+HKj+fH7epwLJFFz0/l0lV7Wcr/8tB1Zh3rlMO+
 q8fCH7NoyIWszn//VK/6mUkS4H/XpoFEKZxpBDxQQePEcJy2LRX+WmlfCocIJbd7Aqwgcu5
 J1JRBLTATUCKof1VGCUpy+AVJx3j1uKpnW2XUENHSOhOX+borvEJHV/0Gs0nCVrXIoMDN2X
 rzeWBJFlkAOtgIZDzyD6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D94fUqZv00w=:UkoadAeuSJ8JZR2OZbaE6d
 BKnDYgnN/ycdD/ksbe351Q5SpySEL9PV6Qw7IZObMpakGPvGIZ2nAv2FkuOTGCHPpZsQlNFxf
 0IgnQVTcU/2m9i5JUwokY+s7IclyNUfUc9JH7YLUImvcHll9t75Ut48KYBDXFxpaSWUDFNS1e
 1n2fxyxbVrzF4wXcKfut1zuWk5MiijhMxni2Oy5DLPPFEwvGNJ4/x7yZ3coqs0pY682Nx+Fko
 LWScvvsoebIDOptaa+7CIHr0W3o392o9LcWiAycGAng4yENZ0TqNPPdeTaLRjP+r3u/mAJH0Z
 ntV5JG6AVmHKd+OvgQyTPgRRS5ilquXHcnPyY9I/iOLkhRZnxJD+GSEjBVdcASPr3cHeQDCFt
 LvkkI8VBYTeWm9zESBNDqB9s4TmnTl7c05PIOVubi2neYEMVAJ/npJS3ppeKQIu+grbL4cdEU
 JaULWHzvd0KPN/XcnejumDD5mKkxtWI1lToBfyz+LyReZT7SRr/4d9PnObUCRTqY+46RCuSQ5
 dAU17WRnNmeFaC+F9z7l6idThh4zJLCM+9i86mzvRAqQx49zxZcR9IIPQ95prdwIar540A/eT
 64BtGo0dNR9isxAgQIzyTBcyagDJmmxvBZIsLZe/zV0gd249SyGArFcSxGANKClPtlzg9GPhc
 prImRsg92+YF9+d4kjl3aZqLo0EZ+PgiDY35eMzIdqlDzij/b7CyWL6oS58ek+Tzsru0dnrEV
 yzW9fQXts6b9sfK2
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thursday 14 April 2016 11:22:58 Kishon Vijay Abraham I wrote:
> 
> IMO simple-phy driver should be an independent driver and shouldn't export
> symbols. The dt binding for the simple phy device should be something like
> below where all the properties of the simple phy device should be in the
> binding documentation.
> usbphy {
>         compatible = "simple-phy";
>         phy-supply = <&supply>;
>         clocks = <&clock>;
>         reset = <&reset>;
> };
> 
> Anything that needs more than this shouldn't be a simple phy.

I think there are two aspects here:

a) I agree that a driver that matches "simple-phy" should only call
   the generic functions and not use any other properties.

b) Independent of that, I think that it makes a lot of sense to export
   those functions from the generic PHY subsystems so they can be
   called from drivers that are a little less generic, or that already
   have an established binding but need no other code.

	Arnd
