Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 15:36:48 +0100 (CET)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33751 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007050AbbLHOgrFleEU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 15:36:47 +0100
Received: by pabur14 with SMTP id ur14so13037232pab.0;
        Tue, 08 Dec 2015 06:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bkOcMSaPf/keqZK5hxD3fD7wfh7uByWVVfS/mo0EwGI=;
        b=b83r4kA9G/RpYcRzNZk+3+14jq4JXmN7JkmbUxG7Z5bkeIQG+nqmAc124TaWa7OzQ9
         E2Cm3HQgWOQgKbiru6He8yaOA3d0zrU6tizKjOdc02SChKyi86AOOkPQrhszHp3/i8Nf
         Hbe6BDAlnXqBRqjgimxntbFpKwqIeLU6SbeVzuJXE3ZgUmIpXlwaP9E0Xr3cvASB02uB
         QoF47ocwCwXKwKZ/2kA8gQSkWsJF8iKjvjcC66xI26agkFTnEujjQNq5PtkyUicUCUSz
         YyhGAlu8m1fs98pmicrhkwmABYtPM5xBIWUPOMUoPheydVPBCZBmrAV13vPpBy+ei4JU
         2Duw==
X-Received: by 10.66.219.163 with SMTP id pp3mr267718pac.55.1449585400748;
        Tue, 08 Dec 2015 06:36:40 -0800 (PST)
Received: from sudip-pc ([122.169.143.75])
        by smtp.gmail.com with ESMTPSA id l20sm5279425pfi.10.2015.12.08.06.36.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 06:36:40 -0800 (PST)
Date:   Tue, 8 Dec 2015 20:06:35 +0530
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Chen Gang <gang.chen.5i5j@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mips: mm: fix build failure
Message-ID: <20151208143635.GD4120@sudip-pc>
References: <1449490164-21029-1-git-send-email-sudipm.mukherjee@gmail.com>
 <5666D493.1030604@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5666D493.1030604@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

On Tue, Dec 08, 2015 at 09:01:07PM +0800, Chen Gang wrote:
> On 12/7/15 20:09, Sudip Mukherjee wrote:
> > We are having build failure with mips defconfig with the error:
> > "MADV_FREE" redefined.
> > 
> > commit d53d95838c7d introduced uniform values for all architecture but
> > missed removing the old value.
> > 
> 
> What you said is OK to me. For me, one fix patch for all related archs
> is enough (need not send several patches for each arch). :-)

Ok, I thought it will be different tree and different maintainer, so
sent separate patch.
Sending a combined patch now.

regards
sudip
