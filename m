Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Feb 2016 20:50:23 +0100 (CET)
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37486 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011968AbcBRTuURid25 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Feb 2016 20:50:20 +0100
Received: by mail-wm0-f50.google.com with SMTP id g62so41335287wme.0
        for <linux-mips@linux-mips.org>; Thu, 18 Feb 2016 11:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SunHvOnEYEJPIegfCEefPMrPKtZ/0CFT6MM3860ICPw=;
        b=Y6TZk+SCOAGlnni6/jpN6yNAvHprSv5sTVdGqx9Uf0GpIgeUwZyj/HlHeyRlVqIYuP
         RAh5yXIeJDLv/9SX02rHktiplWbZtr1PxDbpSiGGnQh3HmZOxjQi5Id1CMxBcTOMB6Pr
         aC7gIkHsc2vMexCLaJw5n7mtlUZl9szsxeyACewEDTUmNkus92JBmGQUGNDQFHZluy0P
         4lJbWpL0bzsSsO6M0bJ/rLuEEdVrXzoVJjqL0hrI5ak2Bz8n0I8FZvB4XbNjmivPyOjJ
         HdZiFgQTd0cgaGHW7cB/d9iSxMeawDRzyDjGwZ4jS7U4gQa8r+MbjyejmEVxOjBs9TFE
         Obkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SunHvOnEYEJPIegfCEefPMrPKtZ/0CFT6MM3860ICPw=;
        b=fg3ipAiQd9PqW9HPB3NDwpxAUf0nyKvd7THcCDB1Ql1Kj4sdsJsX63H+sVRcc0bwzU
         YcQcKFqrJSG2B7ztrSBX+w6H6KgW1EAAnvq3Fsxmmncvq1HPQdEdq3j2cOp4CMHpl0lV
         DB9GoKOKLIWSgaaRqmcwKoe6d9+/Njb3fCPASkNSotiz6KEcKxJceEWFc38kk4xmSJJv
         s3DsPPWuGSG0PI+V8ANgjI628rudZsbm0pqvxUP9uDs6wgMSfucLIG7KB98020RIqk46
         n/Y/0wBu8Ikdy2qQ3rF5DIS4eCaETzkWhoNWDLeYiaqpg2RZTfLO/ZOVJe+6NCp/oWS8
         sXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=SunHvOnEYEJPIegfCEefPMrPKtZ/0CFT6MM3860ICPw=;
        b=MEzoLeKpG686IQ/fSZidrSgvJlPlA0lfN6oBx1iWHOtlujD+zUL1l1rXVTmdUJdOkY
         BjGUy4KclFTORmVcvjK6Mu0VhU+L6i4hqX1fF8sf+1yg716ock4h6bN5Eb/D6sAbPq4b
         RqXTaV/w9gqMqA9K/GSKzztZZEKPSC7dBpmkvdgF1XUFkyhr+G9T8Qhx2w2dcF3ODG0a
         X3Mpy6mAdq0s1Ti63MW+Y2h/lmk19UVH1qfhxPOHoyynAYzr6b+pWokjR2WYbq1onHwc
         euvehnBw1ltJ5GisDqTK1MshmIt/+NPLVtkLWBBwYjZfX9er5bpgHmhmYmsrSP/6zIRc
         N9VQ==
X-Gm-Message-State: AG10YOQHasAKrpMyrUcHrwgWi6IxoWbNapucHJtELMvhlKrdeMxKaihaQ13srQniYrQJBT6Tfin7BCTcqZ6ewxib
X-Received: by 10.28.135.4 with SMTP id j4mr5369609wmd.80.1455825014854; Thu,
 18 Feb 2016 11:50:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.27.18 with HTTP; Thu, 18 Feb 2016 11:49:55 -0800 (PST)
In-Reply-To: <1455328149.2801.82.camel@decadent.org.uk>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
 <1455064168-5102-6-git-send-email-ddecotig@gmail.com> <1455328149.2801.82.camel@decadent.org.uk>
From:   David Decotigny <ddecotig@gmail.com>
Date:   Thu, 18 Feb 2016 11:49:55 -0800
X-Google-Sender-Auth: PcNlEXHX88M_etTWmP55mhCQcOc
Message-ID: <CAG88wWZNB5bT7ywMbcfGbQS=f2gdbC6NpKVt5Opcs-oAbMUjLw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 05/19] net: ethtool: add new
 ETHTOOL_GSETTINGS/SSETTINGS API
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        linux-mips@linux-mips.org, fcoe-devel@open-fcoe.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@emulex.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.Yuval Mintz" <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Return-Path: <decot@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddecotig@gmail.com
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

Sure, I will send an update:

struct ethtool_link_settings {
        __u32   cmd;
        __u32   speed;
        __u8    duplex;
        __u8    port;
        __u8    phy_address;
        __u8    autoneg;
        __u8    mdio_support;
        __u8    eth_tp_mdix;
        __u8    eth_tp_mdix_ctrl;
        __s8    link_mode_masks_nwords;
        __u32   reserved[8];
        __u32   link_mode_masks[0];
};

(+ same renaming for the ioctl sub-cmds)

that would still replace GSET/SSET/ethtool_cmd.

would that be ok?

Or, just to make sure: would you rather keep GSET/SSET/ethtool_cmd as
now for everything but the link mode masks (that would be marked as
deprecated), and have only a new command G/SLINK_MODES + struct
ethtool_link_mode_support that would only take care of the link mode
masks?

On Fri, Feb 12, 2016 at 5:49 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
> On Tue, 2016-02-09 at 16:29 -0800, David Decotigny wrote:
>> From: David Decotigny <decot@googlers.com>
>>
>> This patch defines a new ETHTOOL_GSETTINGS/SSETTINGS API, handled by
>> the new get_ksettings/set_ksettings callbacks. This API provides
>> support for most legacy ethtool_cmd fields, adds support for larger
>> link mode masks (up to 4064 bits, variable length), and removes
>> ethtool_cmd deprecated fields (transceiver/maxrxpkt/maxtxpkt).
> [...]
>
> I previously asked you to include 'link' in the command names and
> structure name.  This would clarify that these are now only for link
> settings and reduce the risk of confusion between old and new commands.
> However, you didn't reply to that review.  Do you have any objection to
> doing this?
>
> Ben.
>
> --
> Ben Hutchings
> Sturgeon's Law: Ninety percent of everything is crap.
