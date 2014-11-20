Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2014 04:04:45 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33876 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014069AbaKTDEoeoYyK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Nov 2014 04:04:44 +0100
Received: by mail-pa0-f42.google.com with SMTP id et14so1600749pad.15
        for <multiple recipients>; Wed, 19 Nov 2014 19:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+djUwrz7KAziiDkezLUC4FgoL9GdlXXPhUjV8Fqc6GA=;
        b=AQ2SIk4FyPsc3JBSwN/BZrj0NW79kJT6iD1s0cYBj7Ey7OlrJ9vDHKWabUuKFF1qCu
         rx3LinsFMvMKmLZgY/qzINmlf4Aghqkl01ti0ryEOq0M8W3NvskJkaKhaYw/9stp+551
         RugIqxg4lDqc7TaarMDUiQkiccaDNaji5711slTXGPgLHiIC6hAmo3blGKzfWq8DKIZ1
         8C4GqkPJ5ko37x9ywlXASIlX/wldDY+Ydd9//punjmyFFZZ9HjA1Vf0w44E0AW1CE6tq
         0cIYlYj6yr5i7//PM7LKgvcW9TmQ6VB4om4fevnegRZCAziRcbd2m9QE5+lLsdnLORbl
         JdKw==
X-Received: by 10.70.47.166 with SMTP id e6mr52286303pdn.43.1416452678238;
        Wed, 19 Nov 2014 19:04:38 -0800 (PST)
Received: from ld-irv-0074 (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id qu6sm509429pbc.92.2014.11.19.19.04.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 19:04:37 -0800 (PST)
Date:   Wed, 19 Nov 2014 19:04:34 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     ralf@linux-mips.org, f.fainelli@gmail.com, jfraser@broadcom.com,
        dtor@chromium.org, tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 00/22] Multiplatform BMIPS kernel
Message-ID: <20141120030434.GE24364@ld-irv-0074>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Sat, Nov 15, 2014 at 04:17:24PM -0800, Kevin Cernekee wrote:
> The lack of a reboot handler is annoying; syscon-reboot probably won't work
> on STB (because it requires two writes).

Can't you reuse drivers/power/reset/brcmstb-reboot.c ?

Brian
