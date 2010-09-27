Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Sep 2010 18:54:47 +0200 (CEST)
Received: from rcsinet10.oracle.com ([148.87.113.121]:33982 "EHLO
        rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491196Ab0I0Qyn (ORCPT
        <rfc822;<linux-mips@linux-mips.org>>);
        Mon, 27 Sep 2010 18:54:43 +0200
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
        by rcsinet10.oracle.com (Switch-3.4.2/Switch-3.4.2) with ESMTP id o8RGs20m019513
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 27 Sep 2010 16:54:03 GMT
Received: from acsmt355.oracle.com (acsmt355.oracle.com [141.146.40.155])
        by acsinet15.oracle.com (Switch-3.4.2/Switch-3.4.1) with ESMTP id o8QNLL7F024019;
        Mon, 27 Sep 2010 16:54:00 GMT
Received: from abhmt013.oracle.com by acsmt355.oracle.com
        with ESMTP id 633788711285606431; Mon, 27 Sep 2010 09:53:51 -0700
Received: from phenom (/209.6.55.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Sep 2010 09:53:46 -0700
Received: by phenom (Postfix, from userid 1000)
        id 9F74D1E66; Mon, 27 Sep 2010 12:53:40 -0400 (EDT)
Date:   Mon, 27 Sep 2010 12:53:40 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Ingo Molnar <mingo@elte.hu>,
        Andre Goddard Rosa <andre.goddard@gmail.com>
Subject: Re: [PATCH 6/9] swiotlb: Declare swiotlb_init_with_default_size()
Message-ID: <20100927165340.GA5644@dumpdata.com>
References: <1285281496-24696-1-git-send-email-ddaney@caviumnetworks.com>
 <1285282051-24907-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1285282051-24907-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad.wilk@oracle.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 21437

On Thu, Sep 23, 2010 at 03:47:30PM -0700, David Daney wrote:
> It comes from swiotlb.c and must be called by external code, so declare it.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Andre Goddard Rosa <andre.goddard@gmail.com>
> ---
>  include/linux/swiotlb.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 8c0e349..dba51fe 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -23,6 +23,7 @@ extern int swiotlb_force;
>  #define IO_TLB_SHIFT 11
>  
>  extern void swiotlb_init(int verbose);
> +extern void swiotlb_init_with_default_size(size_t, int);
>  extern void swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);

Just use the swiotlb_init_with_tbl. If you need an example of how it is utilized, take
a look at how swiotlb-xen.c does it.
