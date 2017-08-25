Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2017 23:21:55 +0200 (CEST)
Received: from mail-wm0-x234.google.com ([IPv6:2a00:1450:400c:c09::234]:35373
        "EHLO mail-wm0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993457AbdHYVVn1yhh7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Aug 2017 23:21:43 +0200
Received: by mail-wm0-x234.google.com with SMTP id y71so735387wmd.0;
        Fri, 25 Aug 2017 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=OFQVyhwjl01oFLmjqn5ZjP5k03XbK4PXM16cyy9YYGU=;
        b=PVXSrThW56ctQNupcY71/G6fgQzr0cL/rET3oYD/D8D2U3333bkiWpqScFKHJHauLl
         SHTT8simitpj/KhJAUqQo+hE/0Z82QH7iB+XhMoo2D1EsCHWybeNCz0u7ghvDHWdqdra
         W05Yi5HdIYxszSQT5vYPsymCen/wkN8sdy4G0er7XhfoMAMDHFEMzzSos0nYESGZzv9I
         s1KzGI3808RidUEGM68RdZjP7on+gVDo/x+1sGse1M0bh8DuNVX/3k5i9nVHw8EJ13N9
         Q/2UFVYE/PBdLg7uEbXWdCpb3oPWYU9lOvUs9E54qRhaHwJSJHmsTPEct7T7dbKPOREn
         hAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=OFQVyhwjl01oFLmjqn5ZjP5k03XbK4PXM16cyy9YYGU=;
        b=b+vtA2JJbRoms9gV99ZM9oyceKmBoMtOmH3rhQZ/mnxP1SUcldHRRXPMMnN6bXkNqO
         e7336ZS6JEiG+756EQ8uyFrUh3VhC2FYJ7sLgXx1zNrje4ypcM2Q6GUNNajBupml9B2c
         i5fhyCOVHRojNfqdc8b32N1Q4ZaEqSsYIcb6yW7QbCrprVpPCGkEC7A2CP4rx40kdBQl
         mdOrXbjPMiYO6bdeZxx+VfTGypNSxr7EWlr1usVHGAcffnaxU15xEE03XpEQE+Ax6gmc
         lMyGP/R4FLL3MyBESCsutiPnNAJ/5JQffre3RyynBYIoJCa5MQdpqK9JQQnAYZZPf26k
         0ApQ==
X-Gm-Message-State: AHYfb5iXJFxDMemeDQoKPk/2aPjmeezYk9XkGEINVTnR9jVJeObeOJJM
        YBxEmm5zTO3PZw==
X-Received: by 10.28.213.203 with SMTP id m194mr314874wmg.41.1503696096961;
        Fri, 25 Aug 2017 14:21:36 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id k9sm3854018wrc.93.2017.08.25.14.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Aug 2017 14:21:36 -0700 (PDT)
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Maintenance of Linux/MIPS?
Cc:     john@phrozen.org, david.daney@cavium.com
Message-ID: <c96eaa42-ab7f-d902-746c-c6cff242c596@gmail.com>
Date:   Fri, 25 Aug 2017 14:21:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59803
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

Hi,

There are a lot of patches at
https://patchwork.linux-mips.org/project/linux-mips/list/ that appear to
be under the "New" state and have not had a chance to be reviewed yet.

What can we do to help speed up the review process, do we need more
reviewers? It seems like most patches affecting Linux/MIPS are still
core MIPS kernel changes, but would it help if say, people were queuing
SoC/board specific patches in trees and submit pull requests? Would that
help lower the amount of patches to review?

Any other suggestion?

Thanks!
-- 
Florian
