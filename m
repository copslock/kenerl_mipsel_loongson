Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 06:50:25 +0200 (CEST)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:36025
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdFEEuLynopk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 06:50:11 +0200
Received: by mail-wm0-x244.google.com with SMTP id k15so27921915wmh.3
        for <linux-mips@linux-mips.org>; Sun, 04 Jun 2017 21:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q0iJLsNQb9loYmgO7gNjPRauVLI8nc5bSmUH0yFJuuo=;
        b=n+vQNzxQOE7zlHffT3YyupTloyeYR7Y3B1a8axArkhRxh9FFx8tQk/X3ZR615GITIL
         sGu7yQCO1QwuEafpw+mITwbWq4DDybPB2NLi0Muz38Y9H45DLxXxTm8Fx5UK5FCkJnR6
         W/9UomeUXmCK3NiiZ+amXJaHWraYQ8kjDnOy9cbuy8QNDNshTrAtjLG8Rq/hgnRrJ3vw
         Vm7i8W0iQ3hWw6o6TJTuRbU+4j+GDA6k6SINDazql+TGnfvK5rkMmP3NVPO9apwG44eH
         YXhfQhlWhByUTU4l10/WUa4XTx0avRCd0ElmlNIVXrI4TMi45LxG5fK9VnkiATXGXqhf
         BOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q0iJLsNQb9loYmgO7gNjPRauVLI8nc5bSmUH0yFJuuo=;
        b=RviPDmUdd12enuHaq5AjCQuCis1YqJI+CCA9lr7Wfhst/2HguGmz2KSAJadA6Dp29o
         RVQvsP5IAMVKpb6uqNvo2I12RsEsgRB7lfLO5i+D0ujsH7hzS4X76EQlfNuCJh0yAlyo
         7CnGRcHT7+eaeZfsutCyzsN2OuDWmjEjfFjqYDBfeSquIFjkg4u3c9PmJArc0IipY/3c
         altMrL5TlGfd5eLVZUa8BXxg/t0/m3sU6pUTy/Tdo9MlxuBUa6mwPAf2OKxlWFEZnKOW
         IaTudRe2A5qjeRot42HpUB1keLsVCOg9K3dZNcmqZ4aW/wl2Dm4jxBKQWPLfjOLdPa2Q
         I3ig==
X-Gm-Message-State: AODbwcCkWyox2pJci+6kXIMYeUcPm8ontNG4EB6uL02+XTS+8V1rrgTO
        bR1hGfk/QAn9L1nk
X-Received: by 10.28.197.11 with SMTP id v11mr6159621wmf.84.1496638206644;
        Sun, 04 Jun 2017 21:50:06 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id l8sm11299796wmd.8.2017.06.04.21.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Jun 2017 21:50:05 -0700 (PDT)
Date:   Mon, 5 Jun 2017 06:50:04 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] net: sched: fix mips build failure
Message-ID: <20170605045004.GA1929@nanopsycho.orion>
References: <1496612653-12419-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496612653-12419-1-git-send-email-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <jiri@resnulli.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiri@resnulli.us
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

Sun, Jun 04, 2017 at 11:44:13PM CEST, sudipm.mukherjee@gmail.com wrote:
>The build of mips ar7_defconfig was failing with the error:
>../net/sched/act_api.c: In function 'tcf_action_goto_chain_init':
>../net/sched/act_api.c:37:18: error:
>	implicit declaration of function 'tcf_chain_get'
>	[-Werror=implicit-function-declaration]
>
>../net/sched/act_api.c: In function 'tcf_action_goto_chain_fini':
>../net/sched/act_api.c:45:2: error:
>	implicit declaration of function 'tcf_chain_put'
>	[-Werror=implicit-function-declaration]
>
>Add two inline helpers for the case where CONFIG_NET_CLS is not enabled.
>
>Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

I already sent a fix for this:

http://patchwork.ozlabs.org/project/netdev/list/
