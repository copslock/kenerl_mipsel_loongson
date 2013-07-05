Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jul 2013 15:31:29 +0200 (CEST)
Received: from mail-ee0-f42.google.com ([74.125.83.42]:62514 "EHLO
        mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823068Ab3GENbVKnZfV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jul 2013 15:31:21 +0200
Received: by mail-ee0-f42.google.com with SMTP id c4so1423917eek.1
        for <linux-mips@linux-mips.org>; Fri, 05 Jul 2013 06:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=XRMiJh2xFMSpbXXpU2Zbo0K6YUCK/HQqDaW+W6rSG68=;
        b=E0G3OBRlbThvYJwj14HF6eLkYlF5DxuREqY7RQXG5iKl+CSCRVuu0lbGMkcpbHbeWN
         VvnVg0GtIc3kwkyahflkKbU1qdo5DXz+p7QofSad0icbUUhEo8qaAfPqV+DELqRIQeOJ
         RX5QqtHfCnBzm6Hi3m3+pKkCNikZEe3ZE8Z/e/VVD231X8/umZONlQewWXWgsLMIzYa5
         FCqJPsLmhJQgq7hGF6q6M+31SxOExLplVj6A2dfGcv7ZBbkx4BD/AXGTMmnriNtiSUEQ
         JVv185KjvlpUg4+ytPiWo5w8VDt+20N0gahrI8a/+8i3Ob0yrgCP90lT/mofT0eDuETO
         cjaw==
X-Received: by 10.14.99.71 with SMTP id w47mr12244844eef.140.1373031074454;
        Fri, 05 Jul 2013 06:31:14 -0700 (PDT)
Received: from gmail.com (host-92-28-211-145.as13285.net. [92.28.211.145])
        by mx.google.com with ESMTPSA id i2sm14044485eeu.4.2013.07.05.06.31.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 06:31:13 -0700 (PDT)
Date:   Fri, 5 Jul 2013 14:29:44 +0100
From:   Andrew Murray <amurray@embedded-bits.co.uk>
To:     ralf@linux-mips.org
Cc:     Andrew.Murray@arm.com, monstr@monstr.eu,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        blogic@openwrt.org, ddaney@caviumnetworks.com, jason@lakedaemon.net
Subject: Re: of_pci_range_parser patch series
Message-ID: <20130705132944.GA6417@gmail.com>
References: <BF39C5705592B0469C55326EC158C01A80307EBE26@GEORGE.Emea.Arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF39C5705592B0469C55326EC158C01A80307EBE26@GEORGE.Emea.Arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQkaiNVABBtFgu2VrbXbl6IcqKSAu6+Sa0zjsKiFsIhT7Adf+BCCcUh/Crh8ZNYyrqLH/YOk
Return-Path: <amurray@embedded-bits.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amurray@embedded-bits.co.uk
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

> Andrew,
> 
> I noticed that [1] is now in -next but not the MIPS patch [2], not the
> MicroBlaze patch [3].  What is the reason for that?  If it's only the
> lack of an ack, here's mine for the MIPS version:

There was no reason other that the missing acks.

> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks for this.

Jason - is it possible/best to take this through your tree?

Andrew Murray

> 
> Thanks,
> 
>   Ralf
> 
> [1] http://patchwork.linux-mips.org/patch/5218/
> [2] http://patchwork.linux-mips.org/patch/5217/
> [3] http://patchwork.linux-mips.org/patch/5216/
