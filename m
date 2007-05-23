Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2007 21:03:42 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:55517 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20021766AbXEWUDf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 May 2007 21:03:35 +0100
Received: (qmail 22737 invoked by uid 101); 23 May 2007 20:02:23 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 23 May 2007 20:02:23 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l4NK2NsI009974;
	Wed, 23 May 2007 13:02:23 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <LGNWX99S>; Wed, 23 May 2007 13:02:23 -0700
Message-ID: <8A9D56C5E50F774BABE033F1710B3576093B15@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Shane McDonald <Shane_McDonald@pmc-sierra.com>
To:	"'Ralf Baechle'" <ralf@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
Cc:	linux-mips@linux-mips.org
Subject: RE: [NET] meth driver renovation
Date:	Wed, 23 May 2007 13:02:18 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Shane_McDonald@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Shane_McDonald@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Should this be:

>  static void __exit meth_exit_module(void)
>  {
> -	unregister_netdev(meth_dev);
> -	free_netdev(meth_dev);
> +	platform_driver_register(&meth_driver);
>  }

                      ^^^^^^^^

      platform_driver_unregister(&meth_driver);
                      ^^

Shane
