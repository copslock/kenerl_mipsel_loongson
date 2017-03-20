Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2017 11:31:20 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:44776 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992881AbdCTKbOLkxBl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Mar 2017 11:31:14 +0100
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ED8D898C;
        Mon, 20 Mar 2017 10:31:05 +0000 (UTC)
Date:   Mon, 20 Mar 2017 11:30:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 4.4 04/35] MIPS: Update defconfigs for
 NF_CT_PROTO_DCCP/UDPLITE change
Message-ID: <20170320103052.GB3047@kroah.com>
References: <20170316142906.685052998@linuxfoundation.org>
 <20170316142906.994447562@linuxfoundation.org>
 <1489939516.2852.71.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1489939516.2852.71.camel@decadent.org.uk>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

I don't know, Arnd was the one that reported it to me.

Arnd?

greg k-h
