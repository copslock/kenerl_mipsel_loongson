Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2011 04:20:07 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:56649 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490945Ab1FICUB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2011 04:20:01 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p592JcO6002506
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 8 Jun 2011 19:19:38 -0700 (PDT)
Received: from tonyliu-laptop.wrs.com (128.224.162.208) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Wed, 8 Jun 2011 19:19:38 -0700
Message-ID: <4DF02DAA.7070902@windriver.com>
Date:   Thu, 9 Jun 2011 10:19:22 +0800
From:   Tonyliu <Bo.Liu@windriver.com>
Reply-To: <Bo.Liu@windriver.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Dezhong Diao <dediao@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Converting MIPS to Device Tree
References: <20110606010753.GA16202@linux-mips.org>
In-Reply-To: <20110606010753.GA16202@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 30302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Bo.Liu@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7476

于 2011年06月06日 09:07, Ralf Baechle 写道:
> Over the past few days I've started to convert arch/mips to use DT.  So
> far none of the platforms (except maybe PowerTV?) seems to have a
> firmware that is passing a DT nor is there any 2nd stage bootloader that
> could do so.
>
> So as the 2nd best thing I've been working on .dts files to be compiled
> into the images.
>
> I've put a git tree of my current working tree online.  It's absolutely
> work in progress so expect to encounter bugs.
>
>    http://git.linux-mips.org/?p=linux-dt.git;a=summary (Gitweb)
>    git://git.linux-mips.org/linux-dt.git
>    
should be git://git.linux-mips.org/pub/scm/linux-dt.git

tonyliu@tonyliu-laptop:/opt/git-root$ git clone 
git://git.linux-mips.org/linux-dt.git dt-linux_mips
Initialized empty Git repository in /opt/git-root/dt-linux_mips/.git/
fatal: The remote end hung up unexpectedly
tonyliu@tonyliu-laptop:/opt/git-root$ git clone 
git://git.linux-mips.org/pub/scm/linux-dt.git dt-linux_mips
Initialized empty Git repository in /opt/git-root/dt-linux_mips/.git/
remote: Counting objects: 2448486, done.
remote: Compressing objects: 100% (446507/446507), done.
Receiving objects: 0% (14786/2448486), 5.26 MiB | 7 KiB/s
Receiving objects: 0% (18463/2448486), 6.56 MiB | 12 KiB/s
Receiving objects: 2% (67572/2448486), 24.25 MiB | 11 KiB/s
Receiving objects: 100% (2448486/2448486), 611.83 MiB | 309 KiB/s, done.
remote: Total 2448486 (delta 2040537), reused 2388725 (delta 1982106)
Resolving deltas: 100% (2040537/2040537), done.
Checking out files: 100% (36749/36749), done.

Tony
>    http://www.linux-mips.org/wiki/Device_Tree (brief documentation&  links)
>
> An incomplete to do list:
>
>    o Sort out interface for firmware to pass a DT to the kernel.  Because we
>      have so many different firmware implementations this one might get a
>      slight bit interesting.
>    o Interface to select one of several builtin DT images.  I am thinking of
>      extending the existing MIPS_MACHINE() / machtype mechanism to play
>      nicely with DT.
>    o Finish and test AR7, Cobalt, Jazz, Malta, MIPSsim and SNI ports.
>    o Convert the remaining platforms; find if it's actually sensible to
>      convert all platforms.
>    o I'm considering to make DT support a requirement for future MIPS
>      platforms so you might as well start beating your firmware monkeys /
>      ask Santa to put you a shiny new bootloader blob into the boot now.
>    o Write more of the required infrastructure.
>    o Write documentation
>
> Contributions and comments welcome,
>
>    Ralf
>
>
>    


-- 
Tony Liu | Liu Bo
-------------------------------------------------------------
WIND RIVER | China Development Center
Tel: 86-10-8477-8542 ext: 8542 |  Fax: 86-10-64790367
(M): 86-136-7117-3612
Address: 15/F, Wangjing TowerB, Chaoyang District, Beijing, P.R.China
