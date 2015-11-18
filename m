Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2015 19:10:28 +0100 (CET)
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35887 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008543AbbKRSK0SFZrA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2015 19:10:26 +0100
Received: by lfs39 with SMTP id 39so32062286lfs.3
        for <linux-mips@linux-mips.org>; Wed, 18 Nov 2015 10:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0R4fNusVWqsPHmTX3Te7Ba3kbgA6PUXOJfxXlPEb/S8=;
        b=FYVlXetHou8Tt+jXB76CH01q5d9N+S21VsnlyiE7Y1lEgKZeTJBwlPEXodcOU9aTuc
         Hhn+wLxy+xdv+6LOdGM8KBr96Nxwr6WJMxhTIFMQurXYHy4b4Z4vowJfnpxT1UkpstpW
         NJDOGcCADWmeQz2aDHWSBFLuKaKULQ4bsEr4L52SpqsEqwf4Hs4Hh21cXKAIZ0erCBzm
         lkLrrPbAJnqBOyEdQkInnw3HNdFcwXGYFq8bfay1jNef+g06ZbZ5IRSwonLgUf1yGoRs
         enToQJRmMIsemF15x3z8VMGw6BJ6OR6tpYG0Z3a9i0DMde4+hAhhtKtp4Q3sP57cgvPE
         mTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0R4fNusVWqsPHmTX3Te7Ba3kbgA6PUXOJfxXlPEb/S8=;
        b=gGKvUcftzTXejfElWmmVYwyayFU/bMRV8Vh5HmlVUFfZUuZ8sSOVqBXj81wNLUdsXl
         AXwIPeo7hfJ6fg28pX7aYUfn7GG4nsQ8KGNcnNbMtiWLsP61GGrYP1IvSMu6sP9vyTW6
         tyj6+09gRn/uJfbEZ3PqsDQDKPvAN9SEAHMiW5xNMKPsNO8hCwnInkE4Qp54p0ahsGLT
         pgfDvwwM4hv8l/DvpIACXewHhoa2Arh0tZQb9GkohV8lHrdTXJZ27A9Cl6hN7/0pOU8E
         chRlHpmAnlnSZ28RpxYMHz1tpWv8LNHrxujysXbQi2sW8ohSEWxbDNyrZZfzeP8FLW2W
         cCZw==
X-Gm-Message-State: ALoCoQmUX9E53aTWr9s93UItSddizqyBghQ7PNrXpB5mBOihOx+bW7sg6cS3N8VioJ/IvnEdJQIf
X-Received: by 10.25.16.158 with SMTP id 30mr1150096lfq.65.1447870220714;
        Wed, 18 Nov 2015 10:10:20 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.30])
        by smtp.gmail.com with ESMTPSA id l67sm592823lfd.43.2015.11.18.10.10.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2015 10:10:19 -0800 (PST)
Subject: Re: [PATCH 1/2] MIPS: ath79: Add a machine entry for booting OF
 machines
To:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org
References: <1447793523-19430-1-git-send-email-albeu@free.fr>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Felix Fietkau <nbd@openwrt.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <564CBF0A.8030205@cogentembedded.com>
Date:   Wed, 18 Nov 2015 21:10:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1447793523-19430-1-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 11/17/2015 11:52 PM, Alban Bedel wrote:

> As I'm using a board with a broken old bootloader I hardcoded the
> mips_machtype and did't noticed that the machine entry was still

    Didn't notice.

> missing.
>
> Signed-off-by: Alban Bedel <albeu@free.fr>

[...]

MBR, Sergei
