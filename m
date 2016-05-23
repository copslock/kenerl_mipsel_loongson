Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 18:21:32 +0200 (CEST)
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35840 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033136AbcEWQVbR6WAE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 18:21:31 +0200
Received: by mail-pf0-f170.google.com with SMTP id c189so68045326pfb.3;
        Mon, 23 May 2016 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=Khiq8rZyRqavS4yl1VTnmHwEciNVi5RrcA1LWZZL9XA=;
        b=lmtEdIlZX2jbQ6TXATyUHmbTpv7T3bJaq1WVuReZJBsReTRjCDrfnBphnPXHq2l2fY
         HbksuUhiiOW/h63yTaAt3wP2bCneW0v2O8XAKrNXuvDePWXLB4Ykgcb05L7G/rLpVQ/f
         jra/ADWrB1YtIszerh50M8FBIh8Mc5+DSqpReUnaApmXgD9wOH6Qlt0ehUCAYjonia4j
         jHsseZWfDC/QRFprQ7VdFUHvSS1Ksj692z9TE/WsMGjZTTSadBm6Ts0SaGaLvlcg/B2I
         y0dy0yzB5taFGhzfo7ySpKQx8HZZoanm+HHMhSUVE4EteACcxv5ESrGk6F50l0UZY37/
         4j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=Khiq8rZyRqavS4yl1VTnmHwEciNVi5RrcA1LWZZL9XA=;
        b=ayi6DpofK+qDXE6Gtpjsc3zIO9Xu6yzEyP0I05saY4n7euGpMeLw3BAtLsPCL/Lfme
         VARm2Yw1Hrf6FH8GLqlAkVnB/B7yxi3/QTWKq1Aq+k8/HxTD3osu5b1mErMxkj4by9w0
         4RuxLB2IsuJyAF/F/5ZbGPpn//SilH/kU5sX4gYcNlSdPJAR67k6kD+UUAx7xH+S3ygh
         CZ6KepI6x4HyKhLJ5fDoXHRnONg8uWNCNOqkk3TMuaLkqLwCJ+xAvqiFHLme65OdSLzA
         jSJz4HpX49fmu/IWWJVh4H9flENCq6yijE0AaAcx2q8TiNHtrw2/tW0fB4rKBUWzym6V
         E88g==
X-Gm-Message-State: AOPr4FWybAoZptGMmxqTOUrZco/VusLju++lz1Kpb7a0xvJ5S0Z0f7VLCCBpiIUakNOUkA==
X-Received: by 10.98.47.194 with SMTP id v185mr28351496pfv.120.1464020485077;
        Mon, 23 May 2016 09:21:25 -0700 (PDT)
Received: from dl.caveonetworks.com ([50.233.148.158])
        by smtp.googlemail.com with ESMTPSA id l123sm47818645pfl.36.2016.05.23.09.21.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 May 2016 09:21:23 -0700 (PDT)
Message-ID: <57432E02.9000008@gmail.com>
Date:   Mon, 23 May 2016 09:21:22 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        Joshua Kinard <kumba@gentoo.org>, linux-mips@linux-mips.org,
        "Hill, Steven" <Steven.Hill@cavium.com>
Subject: Re: THP broken on OCTEON?
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net> <20160523152007.GB28729@linux-mips.org>
In-Reply-To: <20160523152007.GB28729@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53617
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

On 05/23/2016 08:20 AM, Ralf Baechle wrote:
> On Mon, May 23, 2016 at 06:13:46PM +0300, Aaro Koskinen wrote:
>
>> I'm getting kernel crashes (see below) reliably when building Perl in
>> parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
>> Linux 4.6.
>>
>> It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
>> issue - disabling it makes build go through fine.
>>
>> Any ideas?
>
> I thought it was working except on SGI Origin 200/2000 aka IP27 where
> Joshua Kinard (added to cc) was hitting issues as well.
>
> Joshua, does that similar to the issues you were hitting?


There is nothing OCTEON specific in the THP code, or huge pages in general.

That said, we have seen other THP related failures, and have never been 
able to find the cause.

If someone can come up with a reproducible test case that triggers 
quickly, we can run it in our simulator and easily find the problem.

There are THP tweaking knobs in /sys/kernel/mm/transparent_hugepage.  If 
you reduce the time in khugepaged/scan_sleep_millisecs, it often makes 
things fail much more quickly.

David.
