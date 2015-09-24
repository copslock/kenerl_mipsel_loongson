Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2015 09:20:32 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36300 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007433AbbIXHUawlaxb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Sep 2015 09:20:30 +0200
Received: by pablk4 with SMTP id lk4so1263709pab.3;
        Thu, 24 Sep 2015 00:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=x7UhU1MHtbht16CV8x3ez/e8Ki8wML8SHAxddvLzLok=;
        b=QVbsqgBn428HPDKhR7H57XGwDTwVO4vr4VU/dJuSqm9KsFDZgu/7jQuuhDf9/UA43x
         QRoFd3GZCudSs9NBc9BPGWtAMy6KaDaVMa5FM+vike4hY82lEE22uXQIIUFiyb01+NmO
         NP7Pl1TVv3WXoXSfM+Wioe2sJGzoYh4qtcm0hCJRSQgqrmPsDm3hdg0so5HmukfYh0VO
         DskRxtOGuywzPmI5U15bSOO0Xm0hfiDD2zvEs+K8FhBMQi6P8xehxm3Jbs6DxZWUu1Mf
         CfVTLRLoEALM8QQci0B09Wmpz9K4cRSEy2Jyy8bnn4Y8HWFBMvjC+TZ6OlBAGMCwXrKl
         uj7g==
X-Received: by 10.68.94.3 with SMTP id cy3mr41934774pbb.113.1443079223803;
        Thu, 24 Sep 2015 00:20:23 -0700 (PDT)
Received: from sudip-pc ([49.206.240.178])
        by smtp.gmail.com with ESMTPSA id pi9sm11735215pbb.96.2015.09.24.00.20.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Sep 2015 00:20:23 -0700 (PDT)
Date:   Thu, 24 Sep 2015 12:50:17 +0530
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: linux-next: Tree for Sep 23
Message-ID: <20150924072017.GE19202@sudip-pc>
References: <20150923142343.35797c0f@canb.auug.org.au>
 <20150923074207.GA27002@sudip-pc>
 <20150923214236.GA28778@NP-P-BURTON>
 <20150924070744.GD21784@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150924070744.GD21784@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

On Thu, Sep 24, 2015 at 09:07:44AM +0200, Ralf Baechle wrote:
> On Wed, Sep 23, 2015 at 02:42:36PM -0700, Paul Burton wrote:
> 
> > Hi Ralf,
> > 
> > That patch as I submitted it definitely adds arch/mips/mm/sc-debugfs.c
> > but somehow that file has been lost from the commit in your
> > mips-for-linux-next tree. Could you re-apply it?
> 
> Thanks for reporting.  The patch didn't apply cleanly and when applying
> it manually I forgot to git-add the new file.  Of course the file was
> in the local repo so my test builds did succeed.  I fixed that now.
next-20150924 also failed with the same error. I guess next-20150925
should be ok.
Today's build log at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/81906839

regards
sudip
