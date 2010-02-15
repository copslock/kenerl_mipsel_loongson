Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2010 21:28:09 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:53412 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492190Ab0BOU2E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2010 21:28:04 +0100
Received: by bwz7 with SMTP id 7so4290063bwz.26
        for <multiple recipients>; Mon, 15 Feb 2010 12:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=9TmwcbiFEptboJxWGBqb3xk7p0x8bqiLkREGORZG/yU=;
        b=PeY4XH2BZpMDN8gvs6aFUFIGE9zp+DK6xsWIX+GYrXKFkME/Zb0T1qg01J/eoiK0Tp
         1MwF7wf4NSUFaUGhsUyVHMG2v3X9S8Y4mtT251Og02mBZ6ubIqCDPsN4slESzmmUJoHY
         vN8lNmirjswQYzSZjg3/HHb50eO2C1ErLK/so=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=tKr231hEVLTUN3L7xBntxZc4wfghZkJZ1MvlE6lgM7lvlgHdTSK8nKegPIlvWp+Djx
         2sIqkjksIW//5CBge3vnTyMo3z3x+XxBYJMdx2WoZoTZIHdaWy2JFmGuKt3PcNhYNdfL
         GXVLa8HpP18EQxs4K6Xwi0Krfc7TRtRYcC7vo=
Received: by 10.204.49.88 with SMTP id u24mr3607804bkf.44.1266265678493;
        Mon, 15 Feb 2010 12:27:58 -0800 (PST)
Received: from ?127.0.0.1? (gw1.cosmosbay.com [212.99.114.194])
        by mx.google.com with ESMTPS id 16sm2848385bwz.3.2010.02.15.12.27.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 12:27:55 -0800 (PST)
Subject: Re: [PATCH 4/4] Staging: Octeon:  Free transmit SKBs in a timely
 manner.
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
In-Reply-To: <1266264799-3510-4-git-send-email-ddaney@caviumnetworks.com>
References: <4B79AAA6.60005@caviumnetworks.com>
         <1266264799-3510-4-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 15 Feb 2010 21:27:53 +0100
Message-ID: <1266265673.2859.5.camel@edumazet-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 8bit
Return-Path: <eric.dumazet@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.dumazet@gmail.com
Precedence: bulk
X-list: linux-mips

Le lundi 15 février 2010 à 12:13 -0800, David Daney a écrit :
> If we wait for the once-per-second cleanup to free transmit SKBs,
> sockets with small transmit buffer sizes might spend most of their
> time blocked waiting for the cleanup.
> 
> Normally we do a cleanup for each transmitted packet.  We add a
> watchdog type timer so that we also schedule a timeout for 150uS after
> a packet is transmitted.  The watchdog is reset for each transmitted
> packet, so for high packet rates, it never expires.  At these high
> rates, the cleanups are done for each packet so the extra watchdog
> initiated cleanups are not needed.

s/needed/fired/

Hmm, but re-arming a timer for each transmited packet must have a cost ?

> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Is there any particular reason periodic is spelled preiodic ?

> ---
>  }
>  
> -static void cvm_oct_tx_clean_worker(struct work_struct *work)
> +static void cvm_oct_preiodic_worker(struct work_struct *work)
>  {



> -			INIT_DELAYED_WORK(&priv->tx_clean_work,
> -					  cvm_oct_tx_clean_worker);
> -
> +			INIT_DELAYED_WORK(&priv->port_periodic_work,
> +					  cvm_oct_preiodic_worker);
