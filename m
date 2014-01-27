Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 07:56:52 +0100 (CET)
Received: from mail-bk0-f50.google.com ([209.85.214.50]:41187 "EHLO
        mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823063AbaA0G4sTmxwz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jan 2014 07:56:48 +0100
Received: by mail-bk0-f50.google.com with SMTP id w16so2633952bkz.37
        for <linux-mips@linux-mips.org>; Sun, 26 Jan 2014 22:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=t8JK86HsaZAsl18NGDKjCLTUhtrWuaZw3mgjaUdufmM=;
        b=d8d34xxq8K0ePg3d2hT0/XYPggreB2wQH+y4TSYfcQSjpZnBLTA657TbD0Ky5qD7c8
         CSvHfS5/KRJuXZxbD11SwIuaTlVRRzJfe7dkBoZLQcis8Dd5FTwWJMvoGHxnyqIgYySk
         CQ1g3dK2HLSDMY14Gw+aeXlJMoXa8l/ifaU+3glRovk3XXIrPE1J+rC5lNaujLgVQKXv
         qoSiITH6Hn6uIOIaiQsELWpRaAx2qtc2Lig7ghklcxAv66pkJm1PTwvzIPBfhWggqXd9
         vaSPO8eUzgZ9nZFlwCpTmhhDgepV7MJ3P1toFUKeqi4JNmvVUfn3JOiWfJM36DJXo+5Y
         13Lw==
X-Received: by 10.204.228.2 with SMTP id jc2mr5374963bkb.76.1390805802076;
        Sun, 26 Jan 2014 22:56:42 -0800 (PST)
Received: from mailhub.coreip.homeip.net (c-67-188-112-76.hsd1.ca.comcast.net. [67.188.112.76])
        by mx.google.com with ESMTPSA id vx10sm77666761pac.17.2014.01.26.22.56.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 26 Jan 2014 22:56:40 -0800 (PST)
Date:   Sun, 26 Jan 2014 22:56:38 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Raghu Gandham <Raghu.Gandham@imgtec.com>
Cc:     "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: i8042-io - Exclude mips platforms when
 allocating/deallocating IO regions.
Message-ID: <20140127065638.GB11945@core.coreip.homeip.net>
References: <1390676514-30880-1-git-send-email-raghu.gandham@imgtec.com>
 <20140126214952.GD18840@core.coreip.homeip.net>
 <E2EE47005FA75F44B80E1019FDD2EBBB6E38B06D@BADAG02.ba.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E2EE47005FA75F44B80E1019FDD2EBBB6E38B06D@BADAG02.ba.imgtec.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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

On Mon, Jan 27, 2014 at 12:32:36AM +0000, Raghu Gandham wrote:
> Hi Dmitry, 
> 
> > 
> > On Sat, Jan 25, 2014 at 11:01:54AM -0800, Raghu Gandham wrote:
> > > The standard IO regions are already reserved by the platform code on
> > > most MIPS devices(malta, cobalt, sni). The Commit
> > > 197a1e96c8be5b6005145af3a4c0e45e2d651444
> > > ("Input: i8042-io - fix up region handling on MIPS") introduced a bug
> > > on these MIPS platforms causing i8042 driver to fail when trying to reserve
> > IO ports.
> > > Prior to the above mentioned commit request_region is skipped on MIPS
> > > but release_region is called.
> > >
> > > This patch reverts commit 197a1e96c8be5b6005145af3a4c0e45e2d651444
> > and
> > > also avoids calling release_region for MIPS.
> > 
> > The problem is that IO regions are reserved on _most_, but not _all_ devices.
> > MIPS should figure out what they want to do with i8042 registers and be
> > consistent on all devices.
> 
> Please examine the attached patch which went upstream in April of 2004.  Since then
> it had been a convention not to call request_region routine in i8042 for MIPS. The
> attached patch had a glitch that it guarded request_region in i8042-io.h but skipped 
> guarding release_region in i8042-io.h. I believe that the issue Aaro saw was due to this 
> glitch. Below is the error quoted in Aaro's commit message.
> 
>     [    2.112000] Trying to free nonexistent resource <0000000000000060-000000000000006f>
> 
> My patch reinstates the convention followed on MIPS devices along with fixing Aaro's issue.

I assume that Aaro did test his patch and on his box request_region()
succeeds. That would indicate that various MIPS sub-arches still not
settled on the topic.

Aaro?

Thanks.

-- 
Dmitry
