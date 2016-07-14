Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2016 15:39:51 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:17732 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995280AbcGNNjouQUpZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jul 2016 15:39:44 +0200
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u6EDdLJb002180
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 14 Jul 2016 13:39:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u6EDdLIT032337
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 14 Jul 2016 13:39:21 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id u6EDdHNh001471;
        Thu, 14 Jul 2016 13:39:19 GMT
Received: from mwanda (/154.0.139.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jul 2016 06:39:16 -0700
Date:   Thu, 14 Jul 2016 16:39:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ralf@linux-mips.org, markos.chandras@imgtec.com, ast@kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] bpf, mips: fix off-by-one in ctx offset allocation
Message-ID: <20160714133921.GY32247@mwanda>
References: <4ea94c98412d93aaea7f2a28832b41c26dc17ba7.1468497047.git.daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea94c98412d93aaea7f2a28832b41c26dc17ba7.1468497047.git.daniel@iogearbox.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
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

On Thu, Jul 14, 2016 at 01:57:55PM +0200, Daniel Borkmann wrote:
> The cBPF arm and ppc code doesn't have this issue as claimed

Oh, yeah.  You're correct, obviously.  I didn't look carefully.

regards,
dan carpenter
