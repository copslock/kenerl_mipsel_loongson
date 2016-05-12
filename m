Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 06:47:33 +0200 (CEST)
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34851 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029192AbcELErbWDFi3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 06:47:31 +0200
Received: by mail-oi0-f48.google.com with SMTP id x19so101973684oix.2;
        Wed, 11 May 2016 21:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=FdQU8pWCRxTU7iNweGxISlBmw5B2KFNAUaPTd4IVhpA=;
        b=UE69Lb5tkQObkOTgZM45w0E/OaGN2xX+N57Jfcem8auXgdyHtZQYber3vKA7v1DdFv
         I69T1F80Wy/TubxJ/UkqWfwt1GsRdwLHIvW7pJKDkQ9hQ+aq5ndjLiSPDANuQNp36dwJ
         mP1rdJDQtHyNeI2DAXJdWff23AgFvNILgXlfntltPwGTFUZUVZCYFQ0paDqtQ27CcjOb
         n0fQ45t7ma72IyuiSrkk8YlzOav4yxf18sg+pDvUCE439l2Tj/6AVkDYlosWD3myGd5i
         AYcd3Jd4WeP5ss6VWB0V+Py+RuKlOQ7ZPuSIUfUJhqm0RlukXOv4KZCNrHBa5FnfUEay
         keCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=FdQU8pWCRxTU7iNweGxISlBmw5B2KFNAUaPTd4IVhpA=;
        b=fi9+kBrjNZ0SCooFoIkkrKyzgZUs0g3agN29nHwMczmQ1deCItNXOWr2NGNE2wc0Q7
         Xw/F4HbgVyc+2g7IJl2cdW143Noy78VKVfFsO5xzwJ0Hlrs6c+Rsgnc12/L79+qQlUcE
         JpX5ouDSjTztdsJTBo66Uq6UT94U7JVrB59FC2NP+07xZI/ADi78ceVnhJc08Nn1u5xN
         UxFaNZut+bvs46L65Yxv2SLuvFYaafIoc8zok6rsMPhg1Q/LaCS2DCk0yf2mALCUW5u9
         fEml2q8LBqFgWhG9jyQFlWrJmyCzuUj1BPcf64v4sRktQAQAGoA1SSJoxY6DD+TIuAgf
         cKng==
X-Gm-Message-State: AOPr4FXC68IUURHtrT+sp8BZs/or523Ah7g5gZasM7cR2NBu0ZcikVTTl2RtvvgpDN4YVw==
X-Received: by 10.202.203.78 with SMTP id b75mr3655857oig.161.1463028445369;
        Wed, 11 May 2016 21:47:25 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:fd11:36d5:8f47:86e5? ([2001:470:d:73f:fd11:36d5:8f47:86e5])
        by smtp.googlemail.com with ESMTPSA id o31sm3327139oik.20.2016.05.11.21.47.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 May 2016 21:47:24 -0700 (PDT)
Subject: Re: [PATCH] MIPS: tools: Ignore relocation tool
To:     "Maciej W. Rozycki" <macro@imgtec.com>
References: <1462994177-6460-1-git-send-email-f.fainelli@gmail.com>
 <alpine.DEB.2.00.1605120218540.6794@tp.orcam.me.uk>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        matt.redfearn@imgtec.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <57340ADB.5040508@gmail.com>
Date:   Wed, 11 May 2016 21:47:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1605120218540.6794@tp.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53390
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

Le 11/05/2016 18:32, Maciej W. Rozycki a écrit :
> On Wed, 11 May 2016, Florian Fainelli wrote:
> 
>> Add a .gitignore ignoring arch/mips/boot/tools/relocs.
> 
>  It's also left behind after `make distclean' so looks like it's missing a 
> clean-up rule or one hasn't been properly wired.

Whoops did not notice that, I will send a follow-up patch for that too,
thanks!
-- 
Florian
