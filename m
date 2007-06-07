Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 13:51:39 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.168]:11186 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20027202AbXFGMvh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 13:51:37 +0100
Received: by ug-out-1314.google.com with SMTP id m3so737755ugc
        for <linux-mips@linux-mips.org>; Thu, 07 Jun 2007 05:50:36 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QPk6ko0BKq4sVKIbF3n07VLnJ2KDD9/WPCKEMG/WCItPqeNxZJkCFVGark6+m9PUA4gB/g7EcobzUnv2oJy/EJs/m5r7QEcgM+uwH5UDN5blvIIrnUAE50q8kYqmo7G2OlYIVhoLVMIfZC1L5U8tMC4nceNuIwOqNZUQshOrUZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Hp/kOnKw+Oc3AdURq2Cb/zzwmDGmg9j3xTSD+pmYh7MYCftwd6rATzz+GjvD2L1svOtdO/roD/W+Tse5ikCJv9NuWIFTFb6VM0VifoyKlZ6jYYBeWbOIPhLtwxar5p/0twtd6vEMHpy9WF/u46Glvx0wvbQ0K+WD3b3cDLsb28o=
Received: by 10.82.106.14 with SMTP id e14mr3156825buc.1181220636447;
        Thu, 07 Jun 2007 05:50:36 -0700 (PDT)
Received: by 10.82.121.13 with HTTP; Thu, 7 Jun 2007 05:50:36 -0700 (PDT)
Message-ID: <f69849430706070550o76850458w777ee8531be8cfa3@mail.gmail.com>
Date:	Thu, 7 Jun 2007 05:50:36 -0700
From:	"kernel coder" <lhrkernelcoder@gmail.com>
To:	linux-mips@linux-mips.org
Subject: tcp/ip stack question
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,
       I am recieveing the packet on eth1 and want to send it through eth2.

I've written code in netif_recieve_skb function .This code changes the
mac header in sk_buff structure so that it can be send through other
interface card.But when i call ip_dev_find fucntion to get the second
interface structure ,NULL is returned.I checked the ip of second
ethernet card  and it was similar to one passed to ip_dev_find
fucntion,then why NULL is being returned?


Actually if i get the correct dev structure from ip_dev_find fucntion
then i'll assign that dev structure to current skbuff->dev  and call
dev_queue_xmit fucntion,so that it transmitted through second
interface card.Is mine approach correct?


shahzad
