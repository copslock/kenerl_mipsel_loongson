Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2003 22:01:53 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:55283 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225281AbTHFVBv>;
	Wed, 6 Aug 2003 22:01:51 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h76L1nh30035;
	Wed, 6 Aug 2003 14:01:49 -0700
Date: Wed, 6 Aug 2003 14:01:49 -0700
From: Jun Sun <jsun@mvista.com>
To: Michael Pruznick <michael_pruznick@mvista.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: PATCH:2.4:CONFIG_CMDLINE_BOOL
Message-ID: <20030806140149.G18963@mvista.com>
References: <3F316133.3FF2C9EC@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F316133.3FF2C9EC@mvista.com>; from michael_pruznick@mvista.com on Wed, Aug 06, 2003 at 02:12:35PM -0600
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Aug 06, 2003 at 02:12:35PM -0600, Michael Pruznick wrote:
> The patch at the bottom of this message adds support so that
> a board can choose to have a command line specified in
> the .config file or hard-coded. This is similar to what is
> in the ppc tree.  All this patch does is create a config
> question and store the info in the config file.  It is up
> to each board to read or not read this info.
>

This is a good feature.

However, I think it is better to 

1) always have CONFIG_CMDLINE defined
2) for boards that don't use it, it is "" (NULL string)
3) we need to modify all boards' prom_init routines so that they
   respect this config. 
4) (optionally) some ugly static ctrcpy of cmdline can now be
   moved to use config options

Jun
