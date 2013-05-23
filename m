Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 19:00:51 +0200 (CEST)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34119 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835067Ab3EWRAqLZ2DX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 19:00:46 +0200
Received: by mail-pd0-f182.google.com with SMTP id g10so3106858pdj.27
        for <multiple recipients>; Thu, 23 May 2013 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cXvDha7krtc6p/bKBdVpFF3O1wzHakhZh3o2DvL23D4=;
        b=MThrJCmUPkoLEobIhefnEBZZUel1eLAtKYNuCdFim4Pgn6W/aMgd1T00A1leBR7DLQ
         qBKApiDgUnDsnQ+AAj93IbJG1YozDt41ocsO6/UMhBpVNBTz3oqAPpKT0OgQpfFslYv/
         Vt+xK48DMKPEXk2hYVVxE1NVUKB6S57fPbV4tGWSnN2P7+NozBnnfdB2EtrPa+SNXHW+
         d3rDvxX6rZ1kgCd7l4yd5FCAXcJnTjWwR1QUG9Snrq7QyCv+WgAPc6ECUNySmYfDgmoR
         dqK2/Uv+BRrA6JNyq0VSivIL3WvaCxYzpSWrIDR4+G/M/ANu3oN63swskHT19HXosUNR
         qlCA==
X-Received: by 10.68.224.104 with SMTP id rb8mr13754383pbc.206.1369328439595;
        Thu, 23 May 2013 10:00:39 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id nt2sm12419708pbc.17.2013.05.23.10.00.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 23 May 2013 10:00:38 -0700 (PDT)
Message-ID: <519E4B35.10507@gmail.com>
Date:   Thu, 23 May 2013 10:00:37 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@codesourcery.com>,
        "Steven J. Hill" <sjhill@mips.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Trap exception handling fixes
References: <alpine.DEB.1.10.1305230253140.26443@tp.orcam.me.uk> <20130523155009.GA5598@linux-mips.org> <alpine.DEB.1.10.1305231656020.26443@tp.orcam.me.uk> <alpine.DEB.1.10.1305231744460.26443@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.1.10.1305231744460.26443@tp.orcam.me.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/23/2013 09:54 AM, Maciej W. Rozycki wrote:
> On Thu, 23 May 2013, Maciej W. Rozycki wrote:
>
>> It looks to me do_bp would benefit from some polishing too.
>
>   To make myself more clear here -- there are two microMIPS BREAK encodings
> of which do_bp assumes (without checking!) the 32-bit one, that is
> actually unlikely to be ever present in compiler-generated code (so how
> was this change validated?),

Probably sjhill should answer that, as they are his patches.

David Daney


> and also the MIPS16 path is special-cased
> (makes a separate call to do_trap_or_bp), which I find error-prone in
> long-term maintenance.
>
>    Maciej
>
>
>
