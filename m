Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2015 03:57:38 +0200 (CEST)
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34168 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011133AbbJVB5HSegi5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2015 03:57:07 +0200
Received: by oies66 with SMTP id s66so39928629oie.1;
        Wed, 21 Oct 2015 18:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=rVxGSzfeOxS4hI/oMrIooOWYyHco2/mvNjxK/iq3N+U=;
        b=LtSKaVmj+FzQYGvISt2O6uAsLC9cb0KZuOacZMysZU1oQfT/DYIA5XVvGQBKLYnkL8
         legmh02jMc84BnJ0jYcKZEAS0UkLWM2MAG5AqI+6ezOCZY7WIIeoJ9OIhnMMUvcW/IV3
         J0fvrKVp2k61Ix3jI5f1udDVyIIPcwRBWnzVBeHNQt4cNLNdDu7wrpB28lE7r1qQ7L3g
         iDL0ChzBc1RwnovvPznKAvsDNeHI5KnaDYKr7QKhTDvwPsMiEE4q+pEe8g4P4Pw8fsSH
         n1cIsi88/6sWjeZ7tsTUOp/yL5BzHPdvS20ARSQTcj9VwKEnMPAscdRssVZ+5BsjsQqA
         ym0A==
X-Received: by 10.202.74.8 with SMTP id x8mr8221351oia.98.1445479021774;
        Wed, 21 Oct 2015 18:57:01 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:44a6:f084:5dfa:7bd0? ([2001:470:d:73f:44a6:f084:5dfa:7bd0])
        by smtp.googlemail.com with ESMTPSA id n9sm4884598oev.11.2015.10.21.18.57.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2015 18:57:01 -0700 (PDT)
Subject: Re: [PATCH 6/9] MIPS: BMIPS: brcmstb: add I2C node for bcm7346
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-7-git-send-email-jaedon.shin@gmail.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5628426C.1090605@gmail.com>
Date:   Wed, 21 Oct 2015 18:57:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1445395021-4204-7-git-send-email-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49636
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

Le 20/10/2015 19:36, Jaedon Shin a écrit :
> Add I2C device nodes to BMIPS based BCM7346 platform.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
