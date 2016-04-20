Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 15:43:27 +0200 (CEST)
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34586 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027131AbcDTNnZ63BRF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 15:43:25 +0200
Received: by mail-pf0-f176.google.com with SMTP id y69so2627446pfb.1
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=1D5zVExejoj/X3myOHMitT4eSAeiZmQmJbIl1jMqDjc=;
        b=vNvy9h3sH71t4M5J37lxEIrX/K8v7OrXkea1y402CFKQYYPeSek8IFVcZplkjsqlLE
         31LiVnkZfh1iZpzqXnsEcpOmEvHbXcfYxDkG+TsiDvpTXffxbc0GQPBSZAG70Ro7M6nD
         wsIrkyiiXClCBXjB8cg1ofSTgG2kMW5f0FkjGnrd4RJxLb4H8uQY6isRUfQFMzwFeCRo
         6EyKQNgbENYTf/JIJVGXA2eV5+ZAjJpXwoZXXJ2lu5Dki0LrJw6bPxxaFLKSg+DfvrpB
         7Cp4LIHoo7fjYLHY0r7lV+642R6MTASuSrteNOrehEKFuxhM7dKvgps9K4a9yrsP7cIP
         42hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1D5zVExejoj/X3myOHMitT4eSAeiZmQmJbIl1jMqDjc=;
        b=W3KtwQXBZxKO09EignOZjQEazStG7XiA+MgnBHmXZXaUqcNiHs0yWnGbCBXz+o6NfN
         1A+Dp1vpv/C7dgVmQssjuCAuMbsciPcZIVNEcxz2vxNQpXn4T59l8OLCH1cBMD+Wx5pP
         vjABrxtw2ZgAYlsMosatc/qvJ4wgtLRe8fjByVthr/+95pydJ+g7pfeisBPWYmF1PMOF
         MeMlKhi8rS3nmaUrCH4cwO2HU5hz5AAGzeHL7R4s/MUlQ58JFme6jngb+VVZuMlodUvl
         7XUkex+BEAZzKVvx6oWhBH05hRsPJca+EsKzl2cD0kJWqgTB/xQBxgRwLVzCkZsysCAh
         Npjg==
X-Gm-Message-State: AOPr4FXUze73cx2HfrFiU7A2kwvvlBpNiLi5jT0igWL4wrJ/NzHZaIn+OIuvwCPewOuQ2wSV
X-Received: by 10.98.101.193 with SMTP id z184mr12221385pfb.142.1461159800008;
        Wed, 20 Apr 2016 06:43:20 -0700 (PDT)
Received: from [192.168.27.3] ([173.71.13.195])
        by smtp.gmail.com with ESMTPSA id vv8sm98903691pab.22.2016.04.20.06.43.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2016 06:43:19 -0700 (PDT)
Subject: Re: [PATCH] mips: Fix crash registers on non-crashing CPUs
To:     Ralf Baechle <ralf@linux-mips.org>
References: <1460383819-5213-1-git-send-email-minyard@acm.org>
 <57178326.1090801@mvista.com> <20160420133310.GH24051@linux-mips.org>
Cc:     minyard@acm.org, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>
From:   Corey Minyard <cminyard@mvista.com>
Message-ID: <57178776.40902@mvista.com>
Date:   Wed, 20 Apr 2016 08:43:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160420133310.GH24051@linux-mips.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <cminyard@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cminyard@mvista.com
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

On 04/20/2016 08:33 AM, Ralf Baechle wrote:
> On Wed, Apr 20, 2016 at 08:24:54AM -0500, Corey Minyard wrote:
>
>> Anything on this?
> Applied a few days ago and waiting to be pulled by Linus.
>
>    Ralf
Thanks a bunch.

-corey
