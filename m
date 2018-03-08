Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2018 07:57:37 +0100 (CET)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:52712
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994747AbeCHG4tGFpvY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Mar 2018 07:56:49 +0100
Received: by mail-it0-x242.google.com with SMTP id k135so6397131ite.2;
        Wed, 07 Mar 2018 22:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Nh3hDF0kqlJhbCWaZgS6jePrPygoFtXv9+CoD2kJAk=;
        b=frO0iae59g+yFHJeTHAuE8BeLvUhKJsyCZm//fbyP2XnTdkzN72dJeZ2nrZjxAbrPp
         SFyzW2vCj28NjzUdKk6TPN8gJB3t+H11ybS4KMEzYp+V7Zgh8p3q/Mj3j10C4lZMOgs5
         Q/bJYKryJt/WBLVRjAyjyyeICXhEZ6gDipIaJfHFpog+tB/JaEkzYhC+AEsCkDzVdWOy
         vrDCYFmAhUwv2EOIEtdGx5OwMam0RBFyYw0oqaxpF8z1vT2vT6h+22BNn1IYRWG/cKHb
         J4Uf66c4C+VmxXT0phJoMj4JVbfooyLWB79C0OpV94a6Pb1BWG8bA8Ry4ybK0C2Qg96p
         S6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Nh3hDF0kqlJhbCWaZgS6jePrPygoFtXv9+CoD2kJAk=;
        b=YxtIcQBqk+Dt4RLTS+HMdaDnNG6dL5KB/I+uy7gPklTd2F094z6RYPiDx0zGCCC7hj
         9yGm7LDxwnhQenKcYYAf8WcovS6gC5O+W25jChxHpvwQWmMx2GxoE0y8YPKeqymWA8LA
         hwcmIjgW1lSgmy/bZoo/ZBlZ2XMI0oFyAtZvOwAVejfhUJzY9y4h6XN4S+KUNBbhVXRy
         s9AyK4czVpiRg1DTdOyT3mF0q9bhUYTHpf9b9mcMwqgR0pLDogplRVIM0343WRXYwnGT
         VY9Y982tcG3HodAkTYgPrkrcpT5MJzX+J1P3ShAHGad1Gq/unSVNh8so49jRi/MR/yVy
         pHUg==
X-Gm-Message-State: AElRT7FpQBT+b9oypvG2SrpUbh2RhOqCSqj+OI0YP1OJcgYtoG2nhvXw
        Qsa+q6Rn6kNmQgYusrfAv38=
X-Google-Smtp-Source: AG47ELs6yXy9pN2QX2Nh4Q6ZUzxuUZ3q+pKIA4pVcqnCjiuTdBGU3j2qULV7TPdYe82YArB2sUQVbg==
X-Received: by 10.36.78.14 with SMTP id r14mr26821500ita.146.1520492187693;
        Wed, 07 Mar 2018 22:56:27 -0800 (PST)
Received: from [192.168.1.70] (c-73-93-215-6.hsd1.ca.comcast.net. [73.93.215.6])
        by smtp.gmail.com with ESMTPSA id v125sm10286695ith.38.2018.03.07.22.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Mar 2018 22:56:27 -0800 (PST)
Subject: Re: [PATCH] kbuild: Handle builtin dtb files containing hyphens
To:     James Hogan <jhogan@kernel.org>, linux-kbuild@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
References: <20180307140633.26182-1-jhogan@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <2bb96235-6b1f-07bb-3dfe-d5dbb8eddb7f@gmail.com>
Date:   Wed, 7 Mar 2018 22:56:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307140633.26182-1-jhogan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <frowand.list@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frowand.list@gmail.com
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

On 03/07/18 06:06, James Hogan wrote:
> On dtb files which contain hyphens, the dt_S_dtb command to build the
> dtb.S files (which allow DTB files to be built into the kernel) results
> in errors like the following:

< snip >

Hi James,

Sorry for dribbling my comments out in so many emails.  :-)

Please change the subject line to say "dtb filenames" instead
of "dtb files".

Thanks,

Frank
