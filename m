Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2012 08:06:41 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:53363 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901761Ab2ESGGh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 May 2012 08:06:37 +0200
Received: by pbbrq13 with SMTP id rq13so5509588pbb.36
        for <linux-mips@linux-mips.org>; Fri, 18 May 2012 23:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=JnXTj4SR/nUgVt8ZiigBqF7SxAYk1tTRZGD3PLjiZBI=;
        b=MAd2KeTri35WgvBYaLlFp783SOiZFJ/0jTzBugV/80jIIZZFSGBHbljR5rwkakyqiW
         m94bXwn4dkTK3ry1wHQW/v7nhflSs244D72mPYN0eWZ2By+PimLFjtaWwHCnCp0UDl6c
         YwHuhZiR6Ned//yXCZw4Wjt/VXW0qL23j7qRaG4Efmz6kYiOn7BKNKh2GTb/A/wVdCc1
         zvx0hDxmXuriwPlrRoim5vtt33aFVJwuG2A7PUCqOsA7KIqsq9MSbLSwJvHz/XWG5CPW
         lk4HMsOPtHV88QUowekSMH39IsbSaQsRRvd83MxnqMSt4ZsWk2Y7+s0T6/fKdneOmdkz
         kFxw==
Received: by 10.68.226.228 with SMTP id rv4mr18675088pbc.167.1337407591247;
        Fri, 18 May 2012 23:06:31 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id u5sm15240010pbu.76.2012.05.18.23.06.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 23:06:29 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id D3D0B3E046E; Sat, 19 May 2012 00:06:28 -0600 (MDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 2/5] netdev: mdio-octeon.c: Convert to use device tree.
To:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1335489630-27017-3-git-send-email-ddaney.cavm@gmail.com>
References: <1335489630-27017-1-git-send-email-ddaney.cavm@gmail.com> <1335489630-27017-3-git-send-email-ddaney.cavm@gmail.com>
Date:   Sat, 19 May 2012 00:06:28 -0600
Message-Id: <20120519060628.D3D0B3E046E@localhost>
X-Gm-Message-State: ALoCoQlwilZfLpfx62tt7JpojvTTpqdHoRf3b1SYWCk/Zjo0Pxdn5WgCzBGCkceUF9q48pmfAiUl
X-archive-position: 33372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 26 Apr 2012 18:20:27 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Get the MDIO bus controller addresses from the device tree, small
> clean up in use of devm_*
> 
> Remove, now unused, platform device setup code.

Ditto on this one (and the others); make sure the new compatible value
is documented.  Otherwise looks good.

g.
