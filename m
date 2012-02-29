Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Feb 2012 21:36:49 +0100 (CET)
Received: from shards.monkeyblade.net ([198.137.202.13]:44341 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903790Ab2B2Ugo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Feb 2012 21:36:44 +0100
Received: from localhost (cpe-66-65-56-15.nyc.res.rr.com [66.65.56.15])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id q1TKaYo1015866
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Wed, 29 Feb 2012 12:36:36 -0800
Date:   Wed, 29 Feb 2012 15:36:33 -0500 (EST)
Message-Id: <20120229.153633.249570825230282737.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        rob.herring@calxeda.com, linux-kernel@vger.kernel.org,
        david.daney@cavium.com
Subject: Re: [PATCH v6 2/2] of: Make of_find_node_by_path() traverse
 /aliases for relative paths.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1330543264-18103-3-git-send-email-ddaney.cavm@gmail.com>
References: <1330543264-18103-1-git-send-email-ddaney.cavm@gmail.com>
        <1330543264-18103-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: Mew version 6.4 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Wed, 29 Feb 2012 12:36:37 -0800 (PST)
X-archive-position: 32582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <ddaney.cavm@gmail.com>
Date: Wed, 29 Feb 2012 11:21:04 -0800

> Currently all paths passed to of_find_node_by_path() must begin with a
> '/', indicating a full path to the desired node.
> 
> Augment the look-up code so that if a path does *not* begin with '/',
> the path is used as the name of an /aliases property.  The value of
> this alias is then used as the full node path to be found.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

But as the caller you sure as hell know whether you have a "/"
prefixed name or not.

Why complicate an incredibly well designed and simple function for
something you can create another interface for?
