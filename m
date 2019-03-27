Return-Path: <SRS0=CBLp=R6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=BIGNUM_EMAILS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAD8C43381
	for <linux-mips@archiver.kernel.org>; Wed, 27 Mar 2019 08:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CB92075E
	for <linux-mips@archiver.kernel.org>; Wed, 27 Mar 2019 08:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DPlfjKla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbfC0IAF (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:00:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34498 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfC0IAE (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 27 Mar 2019 04:00:04 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2R7wtcF118576;
        Wed, 27 Mar 2019 08:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=0BmciS1SOlSM5+F/Wej2w744TJ+RTaPCKaQsuR7DnE4=;
 b=DPlfjKlaK6ccWZ/Wnt1g5k1iZ3CW7EIXxHXlo6hriWZkQdN/cIfmwHd7Nn7yiALh65xb
 MqpDx0MY8EgnVIoCONQE3UFJVGx4o2amzZngHKmIpgrXcyVG0FIWQ6WACG3a11bapycI
 +au2o6OhCklZGdeYh0rR5POcSwwcZ9GrlwHHaqiiuaEYy1JxKwGt38dWjYc3ZnVy8Ybg
 1owmdMHsGVBamA3mqRB8NZWHyUi0eTyAtYPYOat1L6St5CICX/B2tEDNwvKHNZpFFsX1
 MIy+p7TiQEFVQUjatnF0OCujzRtO0OLRDmcK7W+Oq3Y+lAVnsOeKua7nsNKUWRG+ZjdO Gg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2re6g0xv3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 08:00:01 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2R7xtKn004503
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 07:59:55 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2R7xtiW013763;
        Wed, 27 Mar 2019 07:59:55 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 00:59:54 -0700
Date:   Wed, 27 Mar 2019 10:59:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     tbogendoerfer@suse.de
Cc:     linux-mips@vger.kernel.org
Subject: [bug report] MIPS: SGI-IP27: rework HUB interrupts
Message-ID: <20190327075948.GA18472@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9207 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=483 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903270058
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello Thomas Bogendoerfer,

This is a semi-automatic email about new static checker warnings.

The patch 69a07a41d908: "MIPS: SGI-IP27: rework HUB interrupts" from 
Feb 19, 2019, leads to the following Smatch complaint:

    arch/mips/sgi-ip27/ip27-irq.c:123 shutdown_bridge_irq()
    warn: variable dereferenced before check 'hd' (see line 121)

arch/mips/sgi-ip27/ip27-irq.c
   117  static void shutdown_bridge_irq(struct irq_data *d)
   118  {
   119          struct hub_irq_data *hd = irq_data_get_irq_chip_data(d);
   120		struct bridge_controller *bc;
   121		int pin = hd->pin;
                          ^^^^^^^
Dereference.

   122	
   123		if (!hd)
                    ^^^
Too late.

   124			return;
   125	

regards,
dan carpenter
