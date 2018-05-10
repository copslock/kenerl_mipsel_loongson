Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:58:51 +0200 (CEST)
Received: from userp2120.oracle.com ([156.151.31.85]:46200 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990392AbeENG6oqQjbc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2018 08:58:44 +0200
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w4A6pHRG109980;
        Thu, 10 May 2018 07:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=u/fimI4Ptp/Pe5hIptgJgOOLVv8h7VIVb0gEAdGQGrU=;
 b=cLJrlrjMHFOcMt57R0Mn/qm5G9r3kwtGWoiLO+zNMdlAprz67ZJekUG0kyQaiR7jg0TB
 TWytqNkq4797V9/Mzxe1DRQLGWQApXb/ZesoYl+wwUY+vpPlFeGm8GSlvOxaXO39vBkH
 ydv29VgW6wKhDz082gSrkhaDe+EwZpTh3bbDxU5ZG3XzRFgL+B90WoOIXvOqYdIvG9PC
 JXN6VgjK9kSq5bPBbcTXF1fKym3xbzoV/VpEFt7t0Gtjz95uJAYElajdcDCAO9K9nyfM
 876XvpnLiO3SEhLUJC9YDXRUOtCq6mFQxyyI6UkvvNC3GHF8c9TERIZKjdu9eQFzxCsH zA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2hv6kp24h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 May 2018 07:00:03 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w4A703nK015853
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 May 2018 07:00:03 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w4A70034030532;
        Thu, 10 May 2018 07:00:01 GMT
Received: from mwanda (/197.254.35.146)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 May 2018 23:59:59 -0700
Date:   Thu, 10 May 2018 09:59:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: boston: fix memory leak of 'onecell' on error
 return paths
Message-ID: <20180510065951.fiojonx5f776z5jm@mwanda>
References: <20180509134031.11611-1-colin.king@canonical.com>
 <20180509140135.4dndt3baomtxups5@mwanda>
 <20180509163311.alvyibwwuwkumyxf@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509163311.alvyibwwuwkumyxf@pburton-laptop>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=680
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805100070
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63920
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

It would be nice to make things static check clean.  One idea would be
that the static checker could ignore resource leaks in __init functions.

regards,
dan carpenter
