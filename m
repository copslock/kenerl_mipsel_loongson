Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2011 15:24:15 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:61297 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491148Ab1HANYJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Aug 2011 15:24:09 +0200
Received: by ewy3 with SMTP id 3so3550088ewy.36
        for <linux-mips@linux-mips.org>; Mon, 01 Aug 2011 06:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OF1toX79+5Yjs6+sF1pxb7kib5GuschUHxRXskQ6csk=;
        b=we7tJcClulT7aCK6s4MH+EyQuNOSQdPaVhmeQ4gCpUhXSr+YMHDy2sXmWS108gDqty
         RggdEwokHOVqZOQD3qqVQMwiMQgMUUkNgOLyFZ+5SkvJwTsuRvfiVTQQD6oTW3X93uO5
         dbpQuGxja8NH9uO4LSiEy1pR1o1ggrPqVuBC8=
Received: by 10.204.134.210 with SMTP id k18mr1114437bkt.17.1312205043958;
        Mon, 01 Aug 2011 06:24:03 -0700 (PDT)
Received: from localhost (ppp85-140-16-100.pppoe.mtu-net.ru [85.140.16.100])
        by mx.google.com with ESMTPS id p12sm922735bkp.1.2011.08.01.06.24.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 06:24:02 -0700 (PDT)
Date:   Mon, 1 Aug 2011 17:23:59 +0400
From:   Vasiliy Kulikov <segoon@openwall.com>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: shm broken on MIPS in current -git
Message-ID: <20110801132359.GA11158@albatros>
References: <CAOLZvyEQNS3dwQ+6bh2o6kADp7Gd3xOpah8y1_AhqJ2FWSP9VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLZvyEQNS3dwQ+6bh2o6kADp7Gd3xOpah8y1_AhqJ2FWSP9VA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 30784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: segoon@openwall.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 419

On Mon, Aug 01, 2011 at 14:51 +0200, Manuel Lauss wrote:
> Commits 5774ed014f02120db9a6945a1ecebeb97c2acccb
> (shm: handle separate PID namespaces case)
> and 4c677e2eefdba9c5bfc4474e2e91b26ae8458a1d
> (shm: optimize locking and ipc_namespace getting)
> break on my MIPS systems.  The following oops is
> printed on boot, and as a result, more than  300 zombie kworker
> kernel processes are resident.  I don't see this oops on x86 or x64.

Also it might help if you send the whole config file to me (privately,
as it is too big for ML).

Thanks,

-- 
Vasiliy Kulikov
http://www.openwall.com - bringing security into open computing environments
