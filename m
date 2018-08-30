Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2018 19:35:05 +0200 (CEST)
Received: from mail-by2nam05on0704.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::704]:38720
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993973AbeH3RfBXxYLS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Aug 2018 19:35:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7jmaN8unYDDj0PP8a5hR9JhHuYpvxcIB/vsrMFpGxs=;
 b=OLMYglLxD8uX1cA+9xwje6rFtb80bs8+L8EQqlU0mdH//liBK2IjNxqqDjmWIxxYFYICmClU4Bp1BjwdWk37+r7phTbUpTG2mObVop4Va5Tqq0H5HPl4GYmZKqKbF32JYmuEBVKZLvdLYnxvyO/gmqr9+xKS7eKtgEfmWtOrQM8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Thu, 30 Aug 2018 17:34:17 +0000
Date:   Thu, 30 Aug 2018 10:34:14 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Philippe REYNES <philippe.reynes@softathome.com>
Cc:     linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Use a custom elf-entry program to find kernel
 entry point
Message-ID: <20180830173414.qnpd6dafahh5jxyk@pburton-laptop>
References: <20180829175747.bo4l36aptncduyuc@pburton-laptop>
 <20180829180130.21463-1-paul.burton@mips.com>
 <236153873.582890.1535631758594.JavaMail.zimbra@softathome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <236153873.582890.1535631758594.JavaMail.zimbra@softathome.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2201CA0076.namprd22.prod.outlook.com
 (2603:10b6:301:5e::29) To SN6PR08MB4942.namprd08.prod.outlook.com
 (2603:10b6:805:69::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adfbc9d4-ecfa-4e17-7e4a-08d60e9ecfff
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:glTbDc5ug+tph9rkQSnQWv659GrUOMlaNnNn6fJTFvMDcDYSb0pBLGpVq37EcJvSwV1LEotuY4pCwgnzDdBzL6eWSj3PKbNZxS5osRoGYmzHydoZNs6T182+YqG5zcCUwtu7x2oHOYU5GMeZeBDjJfCzXOcHomWtj4e2m2XOFvldG6RCoPc2S16M/37LC51G/rdrjw75A8Gt6UGLzCpTXDzBxemiKWlIOg+LbW7LCRYconBqzaneP2gmpESxnkIz;25:MESbWlcr/s4VryIaXAaGsKBXxrFus738o8BQkbLhGK0PuYsEeY7PBvcAU04Sb+skXrcQRhwxlktYLW7JfltOeHYKAXqB/oPOegTDWsBVOArer46cuSojGXZNcqz6z3GOslkn5jVxGpuySbjDoFBQgZ9hN8kvSYhrDls1C4zYjVBFluF1LWilBVatp8kolq/1YKnCJbEuYXPBVzkgEeIkVfREuLZ16wD7N1uV7r5H2Ax2ceuPjrV81ziksCMiLG33obGM9UUxk/+CdX07mbL+1vSrhE6N30UewGr6EMpyEVDyX3D0TdZRXML/Top/hk2OEBV45xjPfCPDS9zReiyrMw==;31:monmP7b57ABXImU0ireu3ZL0CrLiZcREd+MoYQ1zyLUjoUV0/rE9tDIHplSTHix6U47Zsg+OpDV3GlNg8Kn9jflqmb0jy6y+e8RvShZvW3bZ7p/Xox/cg9+oDn3eEUxXiRtVt8MXSpi3fqo0+ABmOc9gZCiHNJ858T+J+T9VkR+aJf16532XAz/BZv7co1AHgvPVugzfU4iZ3FhLSAS5Vq0EupK9vUgsbGuB7+ttbGc=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:kmC4k2qaCldQImqJWdMxiPehmCzGsmrUXt8boCSRJdOO8VvloNUg+1mYip+CEmGcWLsuc0IPHAYpYA9OqLRKRmf8FhOjfKOu2TmkRGdiUxeti7GGUJetPCCj9H/7h7x/dII4vRzUCfXlKHSPZw55R0FXTonYMifmpaJ2EiE9rg86SOcU7pg5DOT8ce9oKrIyBcDqBUFFXxA9CH/l0AYV834JibnX3Ato7TN078qfEIZSTsPLjZtYCHIwDKoCh0F0;4:/+/hq8jQzSI/J/lRqSM5zzcoBsyS7SKsnM/M/a5DXkHFPqLzgYC1lXeB05k5YisQL/h6sAK/yi4CHIAVK0CzzOAwfU+oNZ4T0fWsFYZb+BJuEVrjqiN/WmfxJz7VUFGLb+jMwukzjOqkzE6HY/vrB4IwSyh8tFL7p2lMVCuoy66W65KyKXmTDgJFHkUPM37PGnzKnrJxyHZehAXHsKtzpfXQHIWwld9C768vZ+m0LNDuWSoFuVjugMzaqZcTa8MlLsCRKTVYI1AYjUHa7yR+0Q==
X-Microsoft-Antispam-PRVS: <SN6PR08MB494256D02B97254D88C61ADEC1080@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(136003)(39850400004)(366004)(376002)(346002)(199004)(189003)(23726003)(66066001)(53936002)(47776003)(229853002)(68736007)(8936002)(42882007)(486006)(6486002)(6116002)(26005)(186003)(3846002)(1076002)(9686003)(16526019)(44832011)(446003)(2906002)(956004)(11346002)(386003)(50466002)(476003)(16586007)(558084003)(305945005)(6916009)(7736002)(52116002)(76176011)(6666003)(54906003)(33896004)(81156014)(81166006)(316002)(8676002)(97736004)(5660300001)(58126008)(76506005)(105586002)(33716001)(4326008)(6246003)(39060400002)(6496006)(106356001)(25786009)(478600001)(37363001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4942;23:wij9SkPQXAbaZFFQJp67BT9ld1ISFRNInkyYK1dYw?=
 =?us-ascii?Q?73LPl8l1yhQLqqCWcDAAEAyhm8/X5qsTGPNl7kda20xUtDkojM4SDnVS+9+v?=
 =?us-ascii?Q?HENvxI3DxYs1XPMFOFwsW5tIL5j2v1jWxkVyGi9SzedzOooPx8JoYUw5gYyD?=
 =?us-ascii?Q?9lnnNnljmk8g4DWXMS32oYXFRlqN0sIXam2Jdf5KzpwtoxRdj+7zv4OOznEN?=
 =?us-ascii?Q?kubuYxjOL2gsG8PEWsgWu9Lx4Wn/4t2D4sJwhFrz0ld3ZaMjEe4iL53lm8CN?=
 =?us-ascii?Q?D76mmDV8qV3JeBa6NRzwwpvJxJAzA4Ad9xfSufb8kNU4lXnjWan42GT+rIZD?=
 =?us-ascii?Q?q8X1CBHI1EZ2J1JEqbZwf18Zgm4wLmWNV3CrGUCLxZ50QQ8iY/ulaKEG/FUu?=
 =?us-ascii?Q?yNxBjhmP7E6oBoBl5cr//NP55LRtxRBeT4QhJ7LGpCU0l122KC8aJskazujl?=
 =?us-ascii?Q?uREIYSzP81JFqyxfn4PXcqy7mzAARgjUy/yGMQ/SiNCZ1dtUS4SwtWzcCser?=
 =?us-ascii?Q?ZXw4OOzzd63BrmX5H7OuxOnQ4BMStH+87By/zt+xnRHbgDFc75xIvv4He/uL?=
 =?us-ascii?Q?No02zUifHWbyGBaMZ4mPDqqgyIDxAdXORphYySDPtohv968dclWgC/FqNEX1?=
 =?us-ascii?Q?i5OfyO8rysTsbm789zs1bZ9ZSNETmUPWPEX59N9rhU+dXsbBzI0/9Jg58BI4?=
 =?us-ascii?Q?5YBdzFy0ohbzel55z1ON+VH3uKIbktiUWUrzLhu7/e7rJECrO7A3PfU24p5v?=
 =?us-ascii?Q?y4gKJKjoNpT3kV0CwEP5O99wbLpNOMAn6YKdB791thAyFM//OX0pmvrY79Ea?=
 =?us-ascii?Q?YW/CKvavpZHq6m3QupgGCkhyesimw6KpklQ0jD6fPVG52sjaM6xJ+A23vSqv?=
 =?us-ascii?Q?V35gNx2VT8dsi3P4Fosj0K6pbI58PlfoqlC7NKkh/CkodjA44taxJVvZUJSq?=
 =?us-ascii?Q?odw3T20xb4z9f12Vv78dMyZ5ObzIvHCT6GATaDDAZdHx2pZezxuV6mD983WM?=
 =?us-ascii?Q?8kM1hEb2zRnxMkQP+pUtIF9J6EY0RPqhGUqptTmX0w8yNbCRL+mwEdF/JXhf?=
 =?us-ascii?Q?41o3n5pDeqczX8/OzaIgZpPpiw0X2PxIQY+QDxcwwKxoezSVrrwPUhvPkGGX?=
 =?us-ascii?Q?lzbWvmcDs9dXVmWHAqTSVLVTIu1k+zZhteK7BL35kdTj3uFdxPcKJtf8Uw25?=
 =?us-ascii?Q?bYyWNfGcMu+NUd3kzLqnKjVc0a24s9GKzp7uIBRcRAhJqtudv6hcplRIfjYU?=
 =?us-ascii?Q?FDmgfa47tMmOG3bC24/1C58sy7i9V1Fpwehv/9NbWcOOow3jUxRIai37+0yM?=
 =?us-ascii?Q?6Y6pjyLrxhTPaE1QWFHD3O4MjHHg9yIZ81cq1NFoa0A5wzTQdRZMeH7V8cOB?=
 =?us-ascii?Q?xqFKcXNkcjmEORzBmA4nCBngn8=3D?=
X-Microsoft-Antispam-Message-Info: ArT4nQh5smfuUTF4O/Zh+l8g+Zy5LoaInOlkDK3n6+6IjH7yDiNVzadeGb5ELp95uZxj9u3TuQCkZ6bxHFmUw5bkd9rXGamX21Zngvfr7/Pb2vgBgUoiU8GRESWrM729ecs2QGqcpEwKUj421KjNIkD20sH/3MS682H36WHInaVsgGZvo3Ojmu2umOrXQojErbYFwe7wFRHHV31Isb6IQWcj9GqsmKRnButMj2aWWn19473tO+QXj3FpknVaL6bkjU9RPnRAHyVY4RfQb6MTfinmYyDEUbcTNL8c60Lr6/Q8EBWnqYcDv+BV/RMDs7/FvUgOZLxZOS1Z5V/J4U6aMboXY0p93pSLcvY7tvIwx5U=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:h9Rn8j5476NYTNSZ6DWwIx8a2yjSw/IdLSGbLp8DTP+cswfKVPNSYNFU/pMv+kkSYdf1x4ws9wCV23Xikhh+xPhhDh+m1jGIRSze90e2OsE643GPYcaaOGQK4yYK+epe2Y/SyeXNyJP3JTgYmgnXYxj+PKOp3kl3VSRKvDtPMskrwjSxCRpI1P2HLtoy+HNdyB1TIfouCa3g9sgOVaVVY+kKA2vqYuRQqTx5vlZm3OZ/VlBHVDG/RhjAwcqpKqdmVSpzRJqIlz0JSa8qtfIRRBnE4hgKzVK4dOXL7D+sUeeDaKs0tFRSUqPhmKsH6julae1umMXdvS1WFzV+MWmDkfxMHUPALajTF9HcLRGQ81GzCqGQG2J8DBOlE+bDxsO6Y213BL4DaznWsNCXVXJAlXYAQB2C2xnXwyx1NfYS1QoMlYTFN/wqRFM3a2An6804NgwuH7cEb+Rk2Nc+FxoL4w==;5:+216mLdWtVHwEjx8aoBeBOfRjLj33CGHXLyubrAzBCM0gbh5UZJp2mQSgRUl3VuUSYYdJ8OI1o6RdZQ+QYUne9JJ4fqDMGYJrHgdkDHhAcPJ2QU8RQRSBYEihMr4v16gBciH//Xn8PQJGdtutjJxcExI7EKqy9TFHFnxY/To4mA=;7:8FLVLp7NwAoxh6ekKVxUkeigOjZCqO6cKI+Mm7t5jySUsWdWXTh+PAZ8KMFeJNNiTIsu1ft0AZ18ZaAzN6sfI2gaD3Ux6iSJVahOLehv6FoqFuM2Pdst5bkHvgYB3jiZAssTRX/5xxYcRoYA5PdXwzmqWdH7LfDANAT8UnoKP18aWmlF7nWOo9gIINMQVTA4boqLNP341NPc/t02DqDOkEYeegXiz9SVuDVkytTR9wQh2iEEyOYkQnFb8L9OFwcM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 17:34:17.4821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adfbc9d4-ecfa-4e17-7e4a-08d60e9ecfff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Philippe,

On Thu, Aug 30, 2018 at 02:22:38PM +0200, Philippe REYNES wrote:
> I've tested on my "french" machine, and it works fine.
> 
> Tested-by: Philippe Reynes <philippe.reynes@softathome.com>

Merci beaucoup :)

Paul
