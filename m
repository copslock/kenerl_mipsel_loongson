Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2018 13:43:25 +0200 (CEST)
Received: from userp2130.oracle.com ([156.151.31.86]:40780 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992907AbeEPLnTRo0lK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 May 2018 13:43:19 +0200
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w4GBedjJ072104;
        Wed, 16 May 2018 11:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=l/gzVKI1EmoDwHutA5nqLh/8kBV3Z6vTX6XtpUX2dUw=;
 b=nI0/gt2mfBlrBNdFDR2YKbc7Q9jpI98JmjbhPYWgAOKGcWOAHj/nP0PdQxKCC51/vjsE
 bV10O0Noe0r3OVPvuYIsMRNjF1Y72azrHRypB6C/5d5Ie9Abx7g3O962++Vj1LFe/x0H
 uRpxhBFsS/LyYRXGhtqdAlc+C9ByWQ7zOr8JLNkcfZFTtTK2Tm7+XQ0ytPdcEucVli5Z
 oJLBfMDtSHZR07S4V3hhrG5vZoL7RhMA+5IvYumPaOlPaC8HfagRPuSDAq81HfWhJsbb
 IHEnB/pRaGaBvR9RIJWDwuoXN9yjK7dvto4C7Bcu0IKZ8aA72GN1G3GcnyS7+Xh6LkH9 mA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2hx29wce60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 May 2018 11:43:06 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w4GBh4hT017080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 May 2018 11:43:04 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w4GBh2it016772;
        Wed, 16 May 2018 11:43:03 GMT
Received: from mwanda (/197.254.35.146)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 May 2018 04:43:02 -0700
Date:   Wed, 16 May 2018 14:42:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: boston: fix memory leak of 'onecell' on error
 return paths
Message-ID: <20180516114254.wffddft537t45yfg@mwanda>
References: <20180509134031.11611-1-colin.king@canonical.com>
 <20180509140135.4dndt3baomtxups5@mwanda>
 <20180509163311.alvyibwwuwkumyxf@pburton-laptop>
 <20180510065951.fiojonx5f776z5jm@mwanda>
 <152640892003.34267.13202118557714072290@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152640892003.34267.13202118557714072290@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805160119
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63974
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

On Tue, May 15, 2018 at 11:28:40AM -0700, Stephen Boyd wrote:
> Quoting Dan Carpenter (2018-05-09 23:59:51)
> > It would be nice to make things static check clean.  One idea would be
> > that the static checker could ignore resource leaks in __init functions.
> > 
> 
> Typically if the stuff is so important that it doesn't work without it
> then we throw in a panic() or a BUG() call to indicate that all hope is
> lost. Otherwise, I'm not sure what's wrong with adding in proper error
> paths for clean recovery.

In clk_boston_setup() then we'd have to put a ton of BUG()s in there to
silence all the warnings.  Right now the static checkers only care about
kmalloc() but in a year or two they'll be clever enough to care about
everything leaked in this function.  I don't think adding BUG() calls
is a good idea.

Plus, I have a private static checker warning for that.  When the BTRFS
filesystem was merged 10 years ago it used to call BUG() all the time if
allocations failed so I made a static checker warning to spot that
anti-pattern...

regards,
dan carpenter
