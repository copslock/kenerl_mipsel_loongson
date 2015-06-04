Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 10:25:28 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33818 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007342AbbFDIZJBAJgY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 10:25:09 +0200
Received: by payr10 with SMTP id r10so25031365pay.1
        for <linux-mips@linux-mips.org>; Thu, 04 Jun 2015 01:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=df63rX1W7cJgxVoBjVg9SWQNkI/6idFlhs3CkhB6Q8U=;
        b=IzM+AvuyXDE1TwQ0mqQPjMFwppXW+90kjrYcpCY0FK+7MVo/fy7QNM2ClQ3mW1NqHd
         YivfR0F4SbkMkTyyB515jVQYVrCV//klBWFr/Tv90btKPYbZfkBeuc3FdXNXEHM4hWCg
         MtG/jGY8eCzWUvbEAf+EpUPCZXPV6FHrcQw2eWhP5EJ3ir5+/OIYSyFhICp9mj+qBTYv
         BFBQ/iUH7sGRGqInSTe2dsOLIpsNjJQgwJEaWeiiw44gfPL+iP3NztHwKAvVEyF6q+aN
         GQN9Uyx4hBhTDG+NC76Ri06+vKkTFQO8z+lOIMlBzsqEcV8kJu/YOJ9GrFgB3TjhA4JS
         sLMA==
X-Gm-Message-State: ALoCoQm9KEy4smhQPmoRVXcNczD5Zzjtz79Tv9EK5NIIROguzw1jxLBEGGhA7WqIL9VY9rUmeE8+
X-Received: by 10.66.150.169 with SMTP id uj9mr40703514pab.125.1433406301199;
        Thu, 04 Jun 2015 01:25:01 -0700 (PDT)
Received: from trevor.secretlab.ca (p2208095-ipngn17401marunouchi.tokyo.ocn.ne.jp. [153.224.29.95])
        by mx.google.com with ESMTPSA id ph4sm3002809pdb.43.2015.06.04.01.24.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2015 01:24:59 -0700 (PDT)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id B6467C40D75; Thu,  4 Jun 2015 17:02:10 +0900 (JST)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] of: clean-up unnecessary libfdt include paths
To:     Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20150603082638.GJ9839@linux-mips.org>
References: <1433308225-13874-1-git-send-email-robh@kernel.org>
        <20150603082638.GJ9839@linux-mips.org>
Date:   Thu, 04 Jun 2015 17:02:10 +0900
Message-Id: <20150604080210.B6467C40D75@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Wed, 3 Jun 2015 10:26:38 +0200
, Ralf Baechle <ralf@linux-mips.org>
 wrote:
> On Wed, Jun 03, 2015 at 12:10:25AM -0500, Rob Herring wrote:
> > Date:   Wed,  3 Jun 2015 00:10:25 -0500
> > From: Rob Herring <robh@kernel.org>
> > To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
> > Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>,
> >  Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt
> >  <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
> >  Ellerman <mpe@ellerman.id.au>, linux-mips@linux-mips.org,
> >  linuxppc-dev@lists.ozlabs.org
> > Subject: [PATCH] of: clean-up unnecessary libfdt include paths
> > 
> > With the latest dtc import include fixups, it is no longer necessary to
> > add explicit include paths to use libfdt. Remove these across the
> > kernel.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Grant Likely <grant.likely@linaro.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> 
> For the MIPS bits;
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
>   Ralf


Acked-by: Grant Likely <grant.likely@lianro.org>
