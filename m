Received:  by oss.sgi.com id <S553898AbRBTT20>;
	Tue, 20 Feb 2001 11:28:26 -0800
Received: from u-12-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.12]:22254
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553829AbRBTT2V>; Tue, 20 Feb 2001 11:28:21 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1J2pJk02022;
	Mon, 19 Feb 2001 03:51:19 +0100
Date:   Sun, 18 Feb 2001 20:51:19 -0600
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jim Freeman <jfree@sovereign.org>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: bi-endian toolchain switches
Message-ID: <20010218205119.C1644@bacchus.dhis.org>
References: <20010214142024.A5614@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010214142024.A5614@sovereign.org>; from jfree@sovereign.org on Wed, Feb 14, 2001 at 02:20:24PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Feb 14, 2001 at 02:20:24PM -0700, Jim Freeman wrote:

> For bi-endian cross-compiler toolchains, something akin to the following
> patch can be helpful for setting endianness switches according to
> CONFIG_CPU_LITTLE_ENDIAN :

We don't do this because -EB and -EL options don't affect the default
SEARCH_DIR statements in the default linker scripts yet we have to get
ld searching these directories without additional options.  In other words
multilib support is less than perfect ...

  Ralf
