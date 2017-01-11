Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 19:17:30 +0100 (CET)
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:22848
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993908AbdAKSRYQ84Ji convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2017 19:17:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sandiskcorp.onmicrosoft.com; s=selector1-sandisk-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NY+kQeXZdTCL+o+TxsBWYVyK8kK/EXRi4NmCLqVhEII=;
 b=pskBxsC6n4NDYtLFPd4ZJQoaAWUBjsQH1b9ZXj93CPiiOLleK1efiydJ2M2DPFOstsgOqKwulHMzc/Te3+oik9QIulgUDQe+jc/SMcn+eydqAaW+AVQ7Mh6E6/SUUmRqZSmI3Q4JhVqejmY5ekjYMGhr7kNPi8BEX8m3asu62WU=
Received: from BY2PR02CA0061.namprd02.prod.outlook.com (10.141.216.51) by
 BY2PR02MB043.namprd02.prod.outlook.com (10.242.44.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.829.7; Wed, 11 Jan 2017 18:17:07 +0000
Received: from BY2FFO11FD026.protection.gbl (2a01:111:f400:7c0c::105) by
 BY2PR02CA0061.outlook.office365.com (2a01:111:e400:2c40::51) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.829.7 via Frontend
 Transport; Wed, 11 Jan 2017 18:17:07 +0000
Authentication-Results: spf=pass (sender IP is 74.221.232.54)
 smtp.mailfrom=sandisk.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=bestguesspass action=none
 header.from=sandisk.com;
Received-SPF: Pass (protection.outlook.com: domain of sandisk.com designates
 74.221.232.54 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.221.232.54; helo=sacsmgep14.sandisk.com;
Received: from sacsmgep14.sandisk.com (74.221.232.54) by
 BY2FFO11FD026.mail.protection.outlook.com (10.1.15.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.803.8 via Frontend Transport; Wed, 11 Jan 2017 18:17:06 +0000
X-AuditID: ac1c2133-4386e98000013ebf-9f-5876f1701018
Received: from SACHUBIP01.sdcorp.global.sandisk.com (Unknown_Domain [172.28.1.254])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by  (Symantec Messaging Gateway) with SMTP id 1F.C8.16063.071F6785; Wed, 11 Jan 2017 19:01:04 -0800 (PST)
Received: from ULS-OP-MBXIP03.sdcorp.global.sandisk.com
 ([fe80::f9ec:1e1b:1439:62d8]) by SACHUBIP01.sdcorp.global.sandisk.com
 ([10.181.10.103]) with mapi id 14.03.0319.002; Wed, 11 Jan 2017 10:17:04
 -0800
From:   Bart Van Assche <Bart.VanAssche@sandisk.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "mulix@mulix.org" <mulix@mulix.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "uclinux-h8-devel@lists.sourceforge.jp" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "geoff@infradead.org" <geoff@infradead.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "a-jacquiot@ti.com" <a-jacquiot@ti.com>,
        "dalias@libc.org" <dalias@libc.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "lftan@altera.com" <lftan@altera.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "chris@zankel.net" <chris@zankel.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "msalter@redhat.com" <msalter@redhat.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "starvik@axis.com" <starvik@axis.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "stefan.kristiansson@saunalahti.fi" 
        <stefan.kristiansson@saunalahti.fi>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonas@southpole.se" <jonas@southpole.se>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 2/9] Move dma_ops from archdata into struct device
Thread-Topic: [PATCH 2/9] Move dma_ops from archdata into struct device
Thread-Index: AQHSbDbnjGA03SV1IkSgfzaqUBMRJQ==
Date:   Wed, 11 Jan 2017 18:17:03 +0000
Message-ID: <1484158589.2619.14.camel@sandisk.com>
References: <20170111005648.14988-1-bart.vanassche@sandisk.com>
         <20170111005648.14988-3-bart.vanassche@sandisk.com>
         <20170111064803.GB26893@kroah.com>
In-Reply-To: <20170111064803.GB26893@kroah.com>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.1.254]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <BC3FC4DDD21E1E498D9A2E0C11F30769@sandisk.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTdxTG979vvXRWr9XJP7plrnF+wAync+Y4GWHLMu5iTPwwDNON2cgd
        El5sWtfMfVjaFRUom52jDG4JttpQCqXUiyy8NUJlAbcADhLmFAaTqutY2iKZ4nBl1Lqk3355
        zvOc53w5LKmMMhvZwtITgrZUXaxi5JTneRR7RTOvz31VjG6Fiq4lGQz6DAxEGqsQmC+4GHA8
        +oeG+tEyCqbv30IQ/nKJgtBolAaz97YMTte8BXdv+glwhjLBdLGNgZpLqbD4t4kC+5W98OB3
        BwLP2GkGpr3NNNwLiCQ8rosSUGHzyeCOZZKB8NQAAvHKFAXS7AQNAzYLAU0tXhIiZZ0MRMvD
        NIx31zPgCraSK1VnKLBYz8ng9o/XCRhuGGTgbuCrFc1hIqH+cTUJpyZbCXAPt8ogYPUjWHoY
        o2Gsz07A8nftCNr6b1FQKd5hQKoYZ8BvnUFguNZEQ+/ShzAsuQlol6wk/HX9Nwo6foqQEJof
        omDRN0vD9Dk/kbWXD/Y3EPwpv4XhPQ0exI9P/Ezyv3gP8JfdvxJ8lzgl46PzeXx7Uxp/sTdE
        8FJzBcPb24I0P2KLUnx4ZETGd0pzBB+4Wo4ObD0kz8gXigv1gnZ75hH5sWVnO63pXvNZnasa
        GVBgVSVKYTG3C9f+2yGrRHJWyTkJbJtoIeMDJTeG8IMfMuPMcDuxzdJLxXk99yb+ptFMxgMk
        9yfGk+dniUrEsuu4d3FVmz7hycbekTNP/el4wWRn4kxxL+Nm3x90nBUrO12tj1CiuB5hu3Pm
        iSmF244XO0xUfCfiXsBlc8/GZZJLxTeD54nE0Rx29o6SCX4Oh2ZjdII344WmGJPwp+Mb1uqn
        /AYu/96IErwNNzrmyMQNa/G1uiBlQRvEpAoxKS4mxcWkuJgUtyO6GW3QqY/qSgoEzY5d6Tp1
        aX6hrij96PESCT35g5de60QxX3YAcSxSrVLwPfpcJa3W606WBBBmSdV6RVXpiqTIV5/8XNAe
        /1j7abGgC6BNLKVKVbzY15Oj5ArUJ4QiQdAI2v+nBJuy0YC+fm/3YWP+8KWMhe7c+6oe+TuN
        +uKMPaGC7P3r+K7gVQkd3C0ul2+R15p0m+4FIxHj2f7Ct3Ok94Pm/rOTM9astDVas5seyMo1
        BIzmfeHXPwnfWJ3XxbTUaFxDbs+FkKo275lByVg07/j24EdfbDFS+3eaN5v3DOWwEw/7plZ/
        oKJ0x9Q70kitTv0fPHkqrAMEAAA=
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:74.221.232.54;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(7916002)(39410400002)(39450400003)(39840400002)(39860400002)(39850400002)(2980300002)(438002)(199003)(377424004)(189002)(24454002)(38730400001)(39060400001)(229853002)(102836003)(6116002)(6916009)(3846002)(2950100002)(5640700003)(50466002)(8666007)(54906002)(2501003)(103116003)(8936002)(81156014)(8676002)(8746002)(36756003)(2900100001)(81166006)(23756003)(33646002)(69596002)(1730700003)(5660300001)(626004)(305945005)(86362001)(68736007)(110136003)(2906002)(106116001)(7736002)(189998001)(2270400002)(106466001)(356003)(92566002)(7406005)(7416002)(7366002)(54356999)(4326007)(97736004)(50986999)(2351001)(76176999)(47776003)(7099028);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB043;H:sacsmgep14.sandisk.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD026;1:sImSHww0Mqufj+0T9IF/cX8a053HfGs6lIVaW8nXpDHkzcvLgiZsfOrYQndVGsMxjS5R4TKr9PifQ1HVua+TpRsByJuXFY2SaknwrsEoA166+O+gciQg3Vd57OxUEH4FrajYEEjIEyBfTmw+UwbY61BLAfLkwH/NWSSRZkzHJrcn4FvQH0dikCIcRRZaKVSlKr7MqK3fAELplBX1n7whq7QdhLjdPu9Gk1kQmqonl4cmhsRSoxbvzJ62iwSAcekzWyFWZfQ75tQI6fLvawh14Ai8kn9c8TdOdhLqYgzEbxN8EkWMtdPiQJwSn+bX1kkHrUP+mDVoTEotvG53ZpLDGKdYdiPWwfHWO+NfJZ8UYM/zUhhvp2/dQ2rk9iA5OqWULlqYS5KDZ/npbCoKHMGinHCHkSodBIpaP/MRQ8sdeAu96k3b9cSANhmgb0rCl7XQBNiOBuTcjho1PfFPH/B6QDZ0vTBoUBLyB/lG6DuLiLYTCmXLRcvY1CqAPa3+w3l0NlbTFC5QF1jhfLMnQMEnrub5U6YFAFs/eO8BXUbfpQ9yzwSFglHcVeaydnlAReFG+/Zlg9TOP7sLj6xzUaFA7PrQaKWvi1uHx0xHmRltLL8=
X-MS-Office365-Filtering-Correlation-Id: 1f1daeda-44fb-4271-3caf-08d43a4e0d23
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(8251501002);SRVR:BY2PR02MB043;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB043;3:dvfwTIbZFVb+rIloaGSxD7AIVuOIe7p36mlonZl4F32cDvK873NswVEX/nKP1Z7x3fbBk/Ja8+uj3Pg/c2BdNvr3wyvxtP72f1lB7Lg/O3t8u3Oh/ccSz9JYOqafzL8Jy99zABofmggoqgxUaWY5aFY3rcI07XuOm5nbdg0R9DkTf177q6SkrG02sB9kZ9d9LEA9eANiy+aF9ka6Li2g2W1PMqwPJBG+ig4YXHic4NzkAIsZS4ZlasMJbWWa1Zsx9J0UnpjMVHkR3F6AQ/UGHbPk2+fo1VtWR5fIsM8aI0E2QlSaPkkizQOHR7nBx7hj4vpPEJtBYxNv1zamG7ugBeLNe4FjQTkejNHxqUC2SMep1L3NqcuBamD3/Yjw7WZLf94sGUhEMQHWQKyBcvjIbA==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB043;25:IWjI161/EYcY9MBaHuy+hDuZX5FMG0X7BLaF7K6wI9l7xrQ1xGuoYxo4nRABTTRVUJ+RcwgQYNJLzeRSfEkwVKc1VTrj7bnkIYj54v2h5uddcznphf+u0jqny6OoQii9h4bYIxmspFYfhs4nXNBi9jixmFHm4oShciDANI+rLDiygoP/OGbKZoE2Gz085XZki4+2NnvYgLNpiFuqmcI7agJjdKBHzi46E/vhHR4ZxbWwYSevp3PU7KgeL6h7IixzTB4BDlMAjNnbbS7yjb3odzpFloPSm0v7kcpUaKAFS9z8nhKjtpSS6Yg/RohxDFEehxXKCg0ZKS4XJfNEjt/OIXhIZ4iVELYWKbcs788TFA4upZOAhvdCdGvAfx5iVrlSXEaOXvOtnoVZqeU3mZxUFy2kro3bjOknbf4F2ai12b+0dsGpOz3Q5EGRXWdQkxnLqZB5b0KoGY3eu4fNqm/Raxk5o8Ud0sIU9VqCffnc466mk6aK9GKInzvmHzK5UBQHmRYhUTH3SFfV1XCSQLpcna+95nA3UJnJ8Av3X2u6Bk7mZ8P928iTh9Gxc61KlGvF3gP9ww+3hMtcNRFkglTlt45ZT2T42Cq6tBeWACKXpx3B9L0lAQLub7vZeVzU3UhNMskBX4+98UAOWYDXziD/izI6fdw6u12FGoJ6PTJK5wgyKMBuj8+jaPcohCL2ILArM/dEDPKcXJ4yxr2yTOLKDwGShsM+BDjkSeniFlFD0S4uYUrOLcGjAnGJ4wmVNSGtjqCHLSPqPp2egPZUdL+g6gB3LdN7yTglzKnO6dBXVWRQ0Jo074PCh7GJh0v1uLr8FpMAFWNF9tO5nX5n+LyGxJs6zKExTy66AwqDAlle8Zs=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB043;31:b+Cxk1zJayBc/h/4X3mlubcUR1C732mlSH4V2xSgsR28HKhL386RMYyg+haUzT9JdCvxJk8/nZP1NLcSKVbaxyXtdty3UdY/vL3BPhS1KGczM62osUxpa7TxV5M1REDLTX8dLJCFYmrinxUXi9n7xzMWeR5wxWg6heUaL4QPuy8y3/Uxkt9MGjnQOMD9FUxwUv2IMoKY5Q0Cs3q/ljKWLdma2XThCZLWtZcgRzbtNx699T+U1hnNTCzg253mA4VGeM3eP+vk1UUK6w0/krss779hYJDsxlkTGBiuiruzIRs=;20:affC45YmXsPx/15tyh+EJAqVCyZ+NP/PzFDsB4N3BdNtAZHFz7WwaLuW/PhTTFcUbQvvwjDeMMyMQIu0g3rHCVvZaz/Oeg0nXtHFDMCbynCh5ByPRSrXg8K3Rx3qz1zsstZQOeEHpyZ6GBPL7IIa5/BGWxT155bHORJdwi81bhEOVAzFUVmdFF74Ap5BY7KbI1QJ5EImqLdrQEYq8zhlEXi3S2FzATFvflBfL2ADugH9wYHCTa/wDeI5IlyV+fjN2mG6yPR45IlWAP55+xa5m8pmxUHzSPb6IwXz8IRnvc/x8og507LrmcotDZczHITTkq1AfVaKOj5EIKGdEJ5j6G/iZqeWEN0ECfvk7jhlNgYL5oDy/wtQ+eZr1e9tigxc/Wwe0DEvlAEc/0VWqAYFo23kcwvPAxhwx55npCDI2NiMenjgSvKI4PtLp33uJuoWSt6BPa6BLpv3buQue8nQuauf6HLL94Ef62voKebdKQqfFKdVsPZUVev9eejt0FEZ
X-Microsoft-Antispam-PRVS: <BY2PR02MB043DD16B8FDF47FF506190381660@BY2PR02MB043.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(13023025)(13017025)(13015025)(13024025)(13018025)(5005006)(8121501046)(3002001)(10201501046)(6055026)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123560025)(6072148);SRVR:BY2PR02MB043;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB043;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB043;4:6pJIXMpKBzWBD2Be2waEyE8N4QnEzyPb6hlZG0+5t+Jp0xPyLdXYeQmit410lWOgSTv83bXoTfv3s0VPFkAi2VH8/d5IcsxETkGTnrvv4ErVjdE5kdSIlz8dG5i28xaSInzI4v7queueAXzl1d3nEjhgThJPOGBIfEON1kFv4GSdPPz3qCaUWFqrVX8KfBb2Uwg5TCuwIrBrKHQIh9tV4TLCQZptiQRi/cKieWhosTZyu7kaQNAtElTR5HFezFgUqfRa8ABCEHZZeekzHtd2XqCHOlSL7i7BKxmtnT5T085XqTrmfsdHxf9ael8m4+NZ5VCA1WiGhWtXp83vzyRVfoKPSMxf98rbYiDPCb3fPRpN8k7xUNJnksPgaIvjplrk9lohFWRHKv2DwZBBlOHA7S0pn9NLKgrABClqCF7jEUnh+GHhh5eoSDcVOG1hHzY2vqGS2HBriDTAK+XbiLAtZHqorldYubUdLiFX8Rveo0cTkwz5ZWyosARhpBzjOFP7mEKN8y7RuGEyG+WvTn18QImm0NXtNzjrG39/jpbJ7fBOM02NKl3vuMbEI+vDVyNUaU4B7y/Uf8Rf37aQcB6FkDgnZnrqnsqVwfqaHG3ntnvhpBHwrBINYHv60kYVkq/RkfeFs7iVLsKJfnPNAJk72vgLYNi29YJTqz8+xZ8IUSYCY+1ZwYuhg11pvV48JY5S
X-Forefront-PRVS: 01842C458A
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BY2PR02MB043;23:6+zgRUtIEWwBIf5dJdgvLaCDqNHL30MxzDatjOK1?=
 =?iso-8859-1?Q?RGkbA62szOrCpbEkaxYA+hR58EFpeGdDnvBTfsvnKGlC5Tw/Z9D0rm3uHd?=
 =?iso-8859-1?Q?CAaphncjWgqPQs6cGRi65ADm7eHIe8HLIsskO4gW3zk+iiTmVJJGlHgfKl?=
 =?iso-8859-1?Q?US60kqgAjrViHpGk6MH2pkz6W4TLYEkjFBC5Oq2Eb2zhFoiNkFuvx4rIEE?=
 =?iso-8859-1?Q?EccgmVJi3D5OCeBkbFHbgCkQ1kGYbmZlMp1qLTooFSGDF5jfMI3M7gQBrO?=
 =?iso-8859-1?Q?YjkyYZ2ykj4k1BRBq5Jm7meRkfguXHDU6xP+Y2Ohg3fM8e1Rf4sOGzc1Xp?=
 =?iso-8859-1?Q?Z6DXFuGZcrlIACNwx96z19xb5Z+gk2jGEs9QWEB2vX31sG7R+H8o+gyuYN?=
 =?iso-8859-1?Q?M8cDAuduGPhogLHyEeaOV+6Nfx50S+86pkMDYg0Y8cmtwPx1YCq+XITZ6g?=
 =?iso-8859-1?Q?5xprvJ7jyLXtv3Vw1YZ0HO7L45tFO/8a0N0O3UkG44wRrjqoQ5oo1w69uj?=
 =?iso-8859-1?Q?zvapxN09QDkqCFk+oyaliJB3GZ1F+V6Fje+Mr9DPycfpXSbvsBiYeurxVZ?=
 =?iso-8859-1?Q?E8wPN2va6KmKyEpBJ+A1Y8l6izRZUskURqi7tWtgMeU976feaWSaZOnVam?=
 =?iso-8859-1?Q?p963PbwlGJtiMMGFwYrgqBqezW3Ym5yoJky9k9vFN/Z3FGkwry2rskBpC9?=
 =?iso-8859-1?Q?UbvnSQe2JO5x6ZFER1xjLwjNQIQCIls9IHFLFIB5tVJ77i8XB0bHtM6LtV?=
 =?iso-8859-1?Q?V5z+zt0taXUeswv+N2SRlteJOs0d8PrOeqUvF+DYPErkLmBPtbcW97rTLC?=
 =?iso-8859-1?Q?n4hMwPPwSWQpGZBhB8//rFU7qVtJvTtXwrmqlCCCUlAvOYmNB2+jst5sra?=
 =?iso-8859-1?Q?OlX4BCAWQrPz7oYt/x7gCv5fYpQIW1J7APAzAyok+yx4p/3ASmboVYrSIG?=
 =?iso-8859-1?Q?g+GUvK0DPDmAPk1+cX+0Cil6qRaSVlRgzwchq59d2N8ulW4y9/mTzhS2Pe?=
 =?iso-8859-1?Q?65QyrMOl3xTiV28PWUKvIBYk7b20h4YYdsaj+SDOkpit2IQ9NWrV1/EOT8?=
 =?iso-8859-1?Q?Gzc1YSBr7b+3Ewo7U/K3Lw3xzSxgBEdkUmX+l92z5xpeY9LFgPjVeSUImr?=
 =?iso-8859-1?Q?6jAKI4AnGR6S3WX/B+oV7yWLIQDo0hYmPcOPGiyKwlvv5fP6D6MM9YcmUI?=
 =?iso-8859-1?Q?NZ2yEUrUzru2QvJL3YjYB4gILm2PzFvgKIGFTEalRhq12hbBvSAcQ99CFS?=
 =?iso-8859-1?Q?aZGDRHx4Aq5jrlZF8lod8n8Fq6zGFGJUEKQa/jT3tYMKUb+Zr3w2CqKxbC?=
 =?iso-8859-1?Q?9EA+BREzfqTvFC88OzkMMYq90pPgtVKlgjLpz5Wr5JSuArFRYAQErZY8aB?=
 =?iso-8859-1?Q?uv+XKPHRXRMdTUILQWjZ0PWxG0AMIzFEIf+nFBe4NO9aYpyVFNusH9aISx?=
 =?iso-8859-1?Q?LUERCYUkQa3xl76h91axRMHIrY9+w57jrelb4omAzPA7XXvsrDolFeQKYQ?=
 =?iso-8859-1?Q?hOrvDjE/Lps6C7F9XgJv5luu2cNKBZJM8Qyv4culKwEigwZUDGK1zxFo25?=
 =?iso-8859-1?Q?R2Rw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB043;6:KLPv9V/4H6qgzrN+eWR21OR5soCkmIvGekTbTgd5QGFf4r21YNUhbUelctOBphS1lmJmo0iakie/o+UJiwGKOH9e3YCDuXtY1ZMs/mSwcnPr/LpjG6fWfPQ/zwX3p+1DIBIq/sl8Rr6vxsBJNXNotxktniDnUzAte60SYBgkENu4HR9DEq2O8bZ5F+Drx5VM8TkR2qbU9SaYf/5vDWsekX2bylTNtS1MtBZmGPLG1E0fFEPczSPQ//1tKnLEoF08/BD5YJ3X5NG0bDQNDVa8TCEz+PYO4MFinL4h2RZakYb5iX/3L23OhsW9OkcHv7/+EpfmbsLGAAlHH+BBY3joVC3dLid3Bdw/dz/vR30E5cJw3PHsl8Filrpx4bpegkv88U+QSDaUIBNkiAkQ5ezbrShRSjzQIar8pvogYIgTmv5A+ephX/So6wyReW7lrmpxG77Nv6xuOC6g0adiFTVkyQ==;5:5qqFszUJUd7mUcNAJOxbIPByr9wtAH2tI9EYtKDBo1xYSdXqPUSGz8Nvl7+tyL6m6qBxwEfumSGvBELWh4wXOFYhF5rExI6JxCYamYSlZ64PPsD+d7W9P5g9SRJj2qszR2JBCZr/YkKCmLMrATDeULmVna1l9x0QQlbCRALytls=;24:MGHn2IR2RFJsayHsnVe+YU7J+tt1lSUCgukO+FSe+arXRt3YD184W1R5+1FkbC3dS/NlOw6Vm+WD9g9m1znnpTAr1DU3iGdzSeD2wdQwg+E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB043;7:rM7BeYbVELtFYYfIcdJlXOb5t6DWYUFmsNcNu0f8jusuRX2mPpn7oyaXA8WPRpHPWPKMESGvX/27LquFub0OtQz8X4hD90vgTa2nFHljSsYcL6VAUtXFEHAMX/leGCbI3LmK0t8e8o3Xr+r9SRSiS8d1glEnoEhdwn5rmGSx+glbfK5QfIxCvjE9Wv+jWHHOsl4C5Kdon+BILonv4wMAtitkL4OfpBICwP7JDc1Aw4qyNEgTqcXY+LfLfagZ7RcH0i687sm8Lz6oiaUlrz6eFuPbqLr71+QJ9Cc176nW5iNFJzsB0OGZHiCscRp7T9CY+vf6LfFZoaucPc8b62tbGa58PIQqow2ZJZ6B01b+KLcm0EUz/vJ+6p5PP1NhLqX6WXMZwkNeyImE/FK+uIbOuTKEBL18e9UcQyZteFrIcMQjP/OVHdWVQT5Wk9x7drZH7lR0v2xr3phmEF8eo52MRg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2017 18:17:06.1179
 (UTC)
X-MS-Exchange-CrossTenant-Id: fcd9ea9c-ae8c-460c-ab3c-3db42d7ac64d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=fcd9ea9c-ae8c-460c-ab3c-3db42d7ac64d;Ip=[74.221.232.54];Helo=[sacsmgep14.sandisk.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB043
Return-Path: <Bart.VanAssche@sandisk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Bart.VanAssche@sandisk.com
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

On Wed, 2017-01-11 at 07:48 +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 10, 2017 at 04:56:41PM -0800, Bart Van Assche wrote:
> > Several RDMA drivers, e.g. drivers/infiniband/hw/qib, use the CPU to
> > transfer data between memory and PCIe adapter. Because of performance
> > reasons it is important that the CPU cache is not flushed when such
> > drivers transfer data. Make this possible by allowing these drivers to
> > override the dma_map_ops pointer. Additionally, introduce the function
> > set_dma_ops() that will be used by a later patch in this series.
> 
> When you say things like "additionally", that's a huge flag that this
> needs to be split up into multiple patches.  No need to add
> set_dma_ops() here in this patch.

Hello Greg,

Some architectures already define a set_dma_ops() function. So what this
patch does is to move both the dma_ops pointer and the set_dma_ops()
function from architecture-specific to architecture independent code. I
don't think that it is possible to separate these two changes. But I
understand that how I formulated the patch description caused confusion. I
will rewrite the patch description to make it more clear before I repost
this patch series.

> And I'd argue that it should be dma_ops_set(), and dma_ops_get(), just
> to keep the namespace sane, but that's probably a different set of
> patches...

Every time I rebase and retest this patch series on top of a new kernel
version I have to modify some of the patches to compensate for changes in
the architecture code. So I expect that once Linus merges these patches that
he will have to resolve one or more merge conflicts. Including a rename of
the functions that query and set the dma_ops pointer in this patch series
would increase the number of merge conflicts triggered by this patch series
and would make Linus' job harder. So I hope that you will allow me to
postpone that rename until a later time ...

Bart.
From justinpopo6@gmail.com Wed Jan 11 20:44:53 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 20:45:00 +0100 (CET)
Received: from lpdvsmtp01.broadcom.com ([192.19.211.62]:41172 "EHLO
        relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993908AbdAKToxPNcNY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2017 20:44:53 +0100
Received: from mail-irv-17.broadcom.com (mail-irv-17.broadcom.com [10.15.198.34])
        by relay.smtp.broadcom.com (Postfix) with ESMTP id 04C9E2802D1;
        Wed, 11 Jan 2017 11:44:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 relay.smtp.broadcom.com 04C9E2802D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1484163890;
        bh=5WUogODucyNiaQB2A0nAyqk1OMr/MUjr0qN8UEvKlTU=;
        h=From:To:Cc:Subject:Date:From;
        b=fBu+HL6NSCJ1V1RmDebC9dqf9R/PbLAa8R1U4AXV0uBEWthw+a3OnfgBYN2D3Rlmu
         v/ZjYWHKpBQPzEydljfwh6JsWca92Ap/r5bI3vT2cN92u75C1hKjrhkUt+ZQG/xk37
         yqai1ez63Kr6o0GHf+HpMYEuOGgKUjco7dDZa/wc=
Received: from stb-bld-02.irv.broadcom.com (stb-bld-02.broadcom.com [10.13.134.28])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 6DAA281F52;
        Wed, 11 Jan 2017 11:44:49 -0800 (PST)
From:   justinpopo6@gmail.com
To:     linux-mips@linux-mips.org
Cc:     bcm-kernel-feedback-list@broadcom.com, leonid.yegoshin@imgtec.com,
        f.fainelli@gmail.com, Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH] MIPS: Add cacheinfo support
Date:   Wed, 11 Jan 2017 11:44:32 -0800
Message-Id: <20170111194432.24283-1-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.11.0
Return-Path: <justinpopo6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinpopo6@gmail.com
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
Content-Length: 3766
Lines: 124

From: Justin Chen <justin.chen@broadcom.com>

Add cacheinfo support for MIPS architectures.

Use information from the cpuinfo_mips struct to populate the
cacheinfo struct. This allows an architecture agnostic approach,
however this also means if cache information is not properly
populated within the cpuinfo_mips struct, there is nothing
we can do. (I.E. c-r3k.c)

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 arch/mips/kernel/Makefile    |  2 +-
 arch/mips/kernel/cacheinfo.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/kernel/cacheinfo.c

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 4a603a3..904a9c4 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -7,7 +7,7 @@ extra-y		:= head.o vmlinux.lds
 obj-y		+= cpu-probe.o branch.o elf.o entry.o genex.o idle.o irq.o \
 		   process.o prom.o ptrace.o reset.o setup.o signal.o \
 		   syscall.o time.o topology.o traps.o unaligned.o watch.o \
-		   vdso.o
+		   vdso.o cacheinfo.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = -pg
diff --git a/arch/mips/kernel/cacheinfo.c b/arch/mips/kernel/cacheinfo.c
new file mode 100644
index 0000000..a92bbba
--- /dev/null
+++ b/arch/mips/kernel/cacheinfo.c
@@ -0,0 +1,85 @@
+/*
+ * MIPS cacheinfo support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/cacheinfo.h>
+
+/* Populates leaf and increments to next leaf */
+#define populate_cache(cache, leaf, c_level, c_type)		\
+	leaf->type = c_type;					\
+	leaf->level = c_level;					\
+	leaf->coherency_line_size = c->cache.linesz;		\
+	leaf->number_of_sets = c->cache.sets;			\
+	leaf->ways_of_associativity = c->cache.ways;		\
+	leaf->size = c->cache.linesz * c->cache.sets *		\
+		c->cache.ways;					\
+	leaf++;
+
+static int __init_cache_level(unsigned int cpu)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	int levels = 0, leaves = 0;
+
+	/*
+	 * If Dcache is not set, we assume the cache structures
+	 * are not properly initialized.
+	 */
+	if (c->dcache.waysize)
+		levels += 1;
+	else
+		return -ENOENT;
+
+
+	leaves += (c->icache.waysize) ? 2 : 1;
+
+	if (c->scache.waysize) {
+		levels++;
+		leaves++;
+	}
+
+	if (c->tcache.waysize) {
+		levels++;
+		leaves++;
+	}
+
+	this_cpu_ci->num_levels = levels;
+	this_cpu_ci->num_leaves = leaves;
+	return 0;
+}
+
+static int __populate_cache_leaves(unsigned int cpu)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+
+	if (c->icache.waysize) {
+		populate_cache(dcache, this_leaf, 1, CACHE_TYPE_DATA);
+		populate_cache(icache, this_leaf, 1, CACHE_TYPE_INST);
+	} else {
+		populate_cache(dcache, this_leaf, 1, CACHE_TYPE_UNIFIED);
+	}
+
+	if (c->scache.waysize)
+		populate_cache(scache, this_leaf, 2, CACHE_TYPE_UNIFIED);
+
+	if (c->tcache.waysize)
+		populate_cache(tcache, this_leaf, 3, CACHE_TYPE_UNIFIED);
+
+	return 0;
+}
+
+DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
+DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
-- 
2.10.2
