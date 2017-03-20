Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2017 11:04:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43790 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992881AbdCTKDzMx2PR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Mar 2017 11:03:55 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2KA3rs4000402;
        Mon, 20 Mar 2017 11:03:54 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2KA3r3X000401;
        Mon, 20 Mar 2017 11:03:53 +0100
Date:   Mon, 20 Mar 2017 11:03:53 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 4.4 04/35] MIPS: Update defconfigs for
 NF_CT_PROTO_DCCP/UDPLITE change
Message-ID: <20170320100353.GC14919@linux-mips.org>
References: <20170316142906.685052998@linuxfoundation.org>
 <20170316142906.994447562@linuxfoundation.org>
 <1489939516.2852.71.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1489939516.2852.71.camel@decadent.org.uk>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sun, Mar 19, 2017 at 04:05:16PM +0000, Ben Hutchings wrote:
> Date:   Sun, 19 Mar 2017 16:05:16 +0000
> From: Ben Hutchings <ben@decadent.org.uk>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
>  linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
>  linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
> Subject: Re: [PATCH 4.4 04/35] MIPS: Update defconfigs for
>  NF_CT_PROTO_DCCP/UDPLITE change
> Content-Type: multipart/signed; micalg="pgp-sha512";
>         protocol="application/pgp-signature";
>  boundary="=-AwAI9QrjXVRk/IPasf40"
> 
> On Thu, 2017-03-16 at 23:29 +0900, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > commit 9ddc16ad8e0bc7742fc96d5aaabc5b8698512cd1 upstream.
> > 
> > In linux-4.10-rc, NF_CT_PROTO_UDPLITE and NF_CT_PROTO_DCCP are bool
> > symbols instead of tristate, and kernelci.org reports a bunch of
> > warnings for this, like:
> > 
> > arch/mips/configs/malta_kvm_guest_defconfig:63:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
> > arch/mips/configs/malta_defconfig:62:warning: symbol value 'm' invalid for NF_CT_PROTO_DCCP
> > arch/mips/configs/malta_defconfig:63:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
> > arch/mips/configs/ip22_defconfig:70:warning: symbol value 'm' invalid for NF_CT_PROTO_DCCP
> > arch/mips/configs/ip22_defconfig:71:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
> > 
> > This changes all the MIPS defconfigs with these symbols to have them
> > built-in.
> > 
> > Fixes: 9b91c96c5d1f ("netfilter: conntrack: built-in support for UDPlite")
> > Fixes: c51d39010a1b ("netfilter: conntrack: built-in support for DCCP")
> [...]
> 
> I don't think this was needed for 4.4 or 4.9, as those symbols were
> still tristate type.

Indeed, there's no waring for "make ARCH=mips malta_kvm_guest_defconfig".

  Ralf
