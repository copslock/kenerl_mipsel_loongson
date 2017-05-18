Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 May 2017 02:20:17 +0200 (CEST)
Received: from mail-pf0-x22e.google.com ([IPv6:2607:f8b0:400e:c00::22e]:34315
        "EHLO mail-pf0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994850AbdERAUKqsbcN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 May 2017 02:20:10 +0200
Received: by mail-pf0-x22e.google.com with SMTP id 9so14981867pfj.1
        for <linux-mips@linux-mips.org>; Wed, 17 May 2017 17:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+OD9BEc8hzCHQiHn1Hdi8I2DPl7dRDeF9Wyq2GmGkBY=;
        b=Ek8MjupZyPFodM/E5vJBDgxttx+pZdk6ZtsSUD4jT8+RUOSaO14ZvfwDfN3kNB3qQc
         0hajOxIFKL7ymyM/YGaOvSp8tyxRHNIxrT5I9pI6reQpYngFfiLTAuCxI3LEEAdCwFtx
         8FBDw4+kJRaQ4qIaIS58MjQLrm3SP/Hh8fD5suJlXZfZ5E1qhKPhAfD3JQi0VXccTJaW
         kDpNcDNWlgPbtXquYH5A3pmHgcHuwntyguqRwT4pd+k6NlvbymYvxh4ho0+Lcnukri7X
         XEybR7w6aTbM2jV7+fFGf2RHYsSxalQGAk3li10mAxhSyFVva2f0UQZdMkGZxbsKzqQm
         8Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+OD9BEc8hzCHQiHn1Hdi8I2DPl7dRDeF9Wyq2GmGkBY=;
        b=PQ8B1ZmkWl/GawSBtL+qfHSJuBpW6sogS1tf332O0FT4hIA8T+1C10VtoekTebpytp
         E2CrkoBk11hw1lA6zQjVQh1vz22BHgSSztEHRRpvmoa7vCMQq3f8YLJlpbSRUo8ggdHx
         GSde2y3HyrazXnvdEUPCNJNJmAWeuyShmpXtM0Ybnnzk8hCSzToeI1Vmff8G+3KknaAB
         3ZS70+PqOwzI64xPwJ1LWAoDS7v/jqZ6vFAPNlOomx2lf8HR/d0g43G76NMivAKqTNmi
         vS9Q+ocgPtkF5GKuPVIOwuvLBgO6+KyMQFq17JQ8qYCwLaRcfIkJ+zimhHtvcKcLh3fW
         IJjw==
X-Gm-Message-State: AODbwcBF/nivHzaTUIUaTJehyt1D/mZgIXD89eXtMDPYZaFql/sMcTPL
        9AUUaILx0IaGWg==
X-Received: by 10.98.48.131 with SMTP id w125mr1343227pfw.141.1495066804347;
        Wed, 17 May 2017 17:20:04 -0700 (PDT)
Received: from ddl.caveonetworks.com (50-233-148-156-static.hfc.comcastbusiness.net. [50.233.148.156])
        by smtp.googlemail.com with ESMTPSA id j11sm7427503pgn.38.2017.05.17.17.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 May 2017 17:20:03 -0700 (PDT)
Subject: =?UTF-8?Q?Re:_NUBI=e2=80=a6_what_happened_to_it=3f?=
To:     Stuart Longland <stuartl@longlandclan.id.au>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
References: <8f0fa4d9-8bb7-958d-271b-8a3069b209c6@longlandclan.id.au>
From:   David Daney <ddaney.cavm@gmail.com>
Message-ID: <32c06f6b-7373-8b00-89c2-7814f7c584a7@gmail.com>
Date:   Wed, 17 May 2017 17:20:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <8f0fa4d9-8bb7-958d-271b-8a3069b209c6@longlandclan.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57898
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

On 05/13/2017 09:09 PM, Stuart Longland wrote:
> Hi all,
> 
> Silly question, in amongst my digging around for an OS to run on some of
> my older MIPS kit… I recall stumbling on this:
> 
> http://www.linux-mips.org/wiki/NUBI
> 
> Last message I see is from Ralf closing the two lists in December 2009
> after what appears to be an unending onslaught of spam.
> 
> Does anyone recall what eventually happened to those plans?

They were abandoned.  Creating a new ABI is too much work.  Especially 
since for 64-bit architectures, which are the future, NUBI was not 
significantly better than the existing ABIs (n32/n64 + GNU extensions)

> 
> Regards,
> 
