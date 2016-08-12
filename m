Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Aug 2016 01:15:12 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35270 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993501AbcHLXPAuRqYp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Aug 2016 01:15:00 +0200
Received: by mail-pf0-f196.google.com with SMTP id h186so43015pfg.2;
        Fri, 12 Aug 2016 16:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=j/TWGHiZph2T4skG7KQeIVAHQo5Ywzt21IyRGH/noGk=;
        b=0QJNHIcvSGC5Stu+73ndWgmKTJASiD1TP+EOoIAzL8StsY5V3pjiX7APXnDRwTa2vX
         +/LkJw9QHnxpuUIrOKIEAzy+L8eRQjrDvaH2YToqwsfDR7/hGumuZPOz9COWykCHtmOA
         DM5qaeXgIEcrObWxx+g3K9kNz+mPpMLQovMPDfuOHe26VxCvhMa94GKlgEfGZLCTAclo
         O4nfZY+dgjy57AoCqFC6DVBINOKLqBDcQC03Nh8f1IlmQh+GnsX+jz7BkIug3ckDkuC+
         PJcd7+S2QrnlD5DMZDfNxtmjXWX7QweKzj0+MzXcCXrA98GyMyPz0ko3GX2QRTAuQzXd
         FPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=j/TWGHiZph2T4skG7KQeIVAHQo5Ywzt21IyRGH/noGk=;
        b=ciJSD5wT+W8uFbcbjVRARnV8/Y9pcd7NiC8c7fXPkoZu2JcQPAiGAYRl+bGUZheMC/
         v31kToC+/Ob9tYSxNwxEWROWn8UsAOpsu7whLRq+reeeHDfrX/zcL645a/KESlhaAUYv
         Je/rsF/tUCHEg9XEllWgSURlbpRZont5tVuqIrQsXOH6/daTl+AWFC6gynmBFUXnDln2
         V/I3PfHbd/ehjPkN8GJlI3T09dxyb4fPTxwbnEYuDLoTJsf0E1rKh3zng3qxWk6JJOTY
         ayAFGzSqbcL7/u7aEEbQou7WmU4LZQixaIZTX05R/xyUMiUDznQDQgLcW96HaF943p3M
         I4SQ==
X-Gm-Message-State: AEkoouskruBAgNhFj7RNuLBpZPQ9upK/CuqDAJmyc2e4R1kj/VF3ni/NZMIP0i3ZJ1Ayyg==
X-Received: by 10.98.29.201 with SMTP id d192mr31444838pfd.142.1471043694664;
        Fri, 12 Aug 2016 16:14:54 -0700 (PDT)
Received: from [10.112.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id v124sm15504010pfb.14.2016.08.12.16.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Aug 2016 16:14:53 -0700 (PDT)
Subject: Re: [v3 1/5] MIPS: BMIPS: Add support PWM device nodes
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20160812085231.53290-1-jaedon.shin@gmail.com>
 <20160812085231.53290-2-jaedon.shin@gmail.com>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e4d60cb1-5b4f-8b20-a8fe-8a1c91f03499@gmail.com>
Date:   Fri, 12 Aug 2016 16:14:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160812085231.53290-2-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 08/12/2016 01:52 AM, Jaedon Shin wrote:
> Adds PWM device nodes to BCM7xxx MIPS based SoCs.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
