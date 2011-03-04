Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2011 22:55:39 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:38647 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491880Ab1CDVzd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2011 22:55:33 +0100
Received: by pwi8 with SMTP id 8so477208pwi.36
        for <multiple recipients>; Fri, 04 Mar 2011 13:55:26 -0800 (PST)
Received: by 10.142.127.16 with SMTP id z16mr821655wfc.319.1299275726487;
        Fri, 04 Mar 2011 13:55:26 -0800 (PST)
Received: from angua (S01060002b3d79728.cg.shawcable.net [70.72.87.49])
        by mx.google.com with ESMTPS id m10sm3499935wfl.23.2011.03.04.13.55.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Mar 2011 13:55:25 -0800 (PST)
Received: by angua (Postfix, from userid 1000)
        id 8B3DD3C00D3; Fri,  4 Mar 2011 14:55:24 -0700 (MST)
Date:   Fri, 4 Mar 2011 14:55:24 -0700
From:   Grant Likely <grant.likely@secretlab.ca>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/12] of: Make of_find_node_by_path() traverse
 /aliases for relative paths.
Message-ID: <20110304215524.GB7579@angua.secretlab.ca>
References: <1299267744-17278-1-git-send-email-ddaney@caviumnetworks.com>
 <1299267744-17278-4-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1299267744-17278-4-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Fri, Mar 04, 2011 at 11:42:15AM -0800, David Daney wrote:
> Currently all paths passed to of_find_node_by_path() must begin with a
> '/', indicating a full path to the desired node.
> 
> Augment the look-up code so that if a path does *not* begin with '/',
> the path is used as the name of an /aliases property.  The value of
> this alias is then used as the full node path to be found.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
> 
> This patch is unchanged from the previous version I send separately.  I
> have not forgotten about Grant's feedback, just deferred it to the
> next version.

okay; I'll wait for the next version before I consider picking it up.

g.
